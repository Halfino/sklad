require_relative "robot.rb"
storehouse_arr = []
robots = []

class Core
  attr_reader :storehouse
  attr_accessor :robots

  def initialize(robots, storehouse)
    @robots = robots
    @storehouse = storehouse
  end

  def run
    steps = (@robots.sort_by { |x| x.instructions.length}.reverse)[0].instructions.length

    steps.times do
      @robots.each do |robot|

        instruction = robot.instructions.shift

        if robot.status == "OK"
          case instruction
            when "U"
              robot.move_up
            when "L"
              robot.move_left
            when "R"
              robot.move_right
            when "D"
              robot.move_down
            else

          end
        end
      end

      @robots.each {|robot| check_collision(robot)}
    end
  end

  def check_collision(robot)
    if @storehouse[robot.possition_x][robot.possition_y] == "X"
      robot.status = "Collided"
    end

    @robots.each do |rob|
      if (robot.possition_x == rob.possition_x && robot.possition_y == rob.possition_y) && robot.name != rob.name
        robot.status = "Collided"
      end
    end
  end

end

File.open("sklad.txt", "r") do |f|
  while line = f.gets
    storehouse_arr << line.strip.split("")
  end
end

File.open("roboti.txt", "r") do |f|
  while line = f.gets
    row = line.strip.split(",")
    coords_helper = row[1].split("x")
    instructions = row[2..(row.length - 1)]
    robots << Robot.new(row[0], coords_helper[0].to_i,coords_helper[1].to_i, "OK", instructions)
  end
end


storehouse = Core.new(robots, storehouse_arr)
storehouse.run

File.open("result.txt", "w") do |f|
  robots.each do |robot|
    f.puts "#{robot.name}(#{robot.possition_x}x#{robot.possition_y}):#{robot.status}"
  end
end