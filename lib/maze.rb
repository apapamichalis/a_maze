# Holds the definition of a valid Maze object
#
# A valid maze object consists of a two-dimensional array (the maze),
# the starting point of the maze and a goal point of the maze
class Maze
  def initialize(map, start, goal)
    @map   = ['S', 'G'] 
    @start = [0,0]
    @goal  = [0,1]
    validate_maze
  end

  attr_reader :map
  attr_reader :start
  attr_reader :goal

  private
    def validate_maze
      validate_dimensions
      validate_start
      validate_goal
    end

    def validate_dimensions
    end

    def validate_start
    end

    def validate_goal
    end
end
