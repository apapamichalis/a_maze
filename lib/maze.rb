# Holds the definition of a valid Maze object
#
# A valid maze object consists of a two-dimensional array (the maze),
# the starting point of the maze and a goal point of the maze
class Maze
  attr_reader :maze_array
  attr_reader :start
  attr_reader :goal

  # Maze validation can be turned off, as it slows down loading considerably.
  def initialize(maze_array, start, goal, validations = true)
    @maze_array = maze_array 
    @start      = start
    @goal       = goal
    validate_maze if validations
  end

  private

    def validate_maze
      validate_length
      validate_characters
      validate_dimensions
      validate_start
      validate_goal
      validate_dif_start_goal
    end

    # Only valid characters allowed S, G, _, X
    def validate_characters
      @maze_array.each do |row| 
        row.each { |c| raise 'Maze includes invalid characters' if c =~ /[^SG_X]/ }
      end
    end

    # All rows must have equal length
    def validate_dimensions
      l = @maze_array[0].length
      @maze_array.each { |row| raise 'Maze is not rectangular' if row.length != l }
    end

    # Maze has minimum 2 blocks
    def validate_length
      raise "Maze is smaller than required" if @maze_array.flatten.length < 2
    end

    # Starting point cannot be outside maze map or on a wall
    def validate_start
      r, c = @start
      if r < 0 || c < 0 || r > @maze_array.length-1 || c > @maze_array[0].length-1 || @maze_array[r][c] == 'X'
        raise 'Definition includes wrong starting point'  
      end
    end

    # Goal point cannot be outside maze map or on a wall
    def validate_goal
      r, c = @goal
      if r < 0 || c < 0 || r > @maze_array.length-1 || c > @maze_array[0].length-1 || @maze_array[r][c] == 'X'
        raise 'Definition includes wrong goal point'  
      end
    end

    # Starting and goal points cannot be the same
    def validate_dif_start_goal
      raise 'Start and goal cannot be the same' if @start == @goal
    end
end
