class Robot
  attr_reader :name, :instructions
  attr_accessor :possition_x, :possition_y, :status
  def initialize(name, possition_x, possition_y, status, instructions)
    @name = name
    @possition_x = possition_x
    @possition_y = possition_y
    @status = status
    @instructions = instructions
  end

  def move_up
    @possition_x -= 1
  end

  def move_down
    @possition_x += 1
  end

  def move_left
    @possition_y -= 1
  end

  def move_right
    @possition_y += 1
  end

end