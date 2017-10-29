# Holds the definition of a valid Maze object
#
# A valid maze object consists of a two-dimensional array (the maze),
# the starting point of the maze and a goal point of the maze
class Maze
  attr_reader :map
  attr_reader :start
  attr_reader :goal

  # Maze validation can be turned off, as it slows down loading considerably.
  def initialize(map, start, goal, validations = true)
    @map   = map 
    @start = start
    @goal  = goal
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

    def validate_characters
      @map.each do |row| 
        row.each { |c| raise 'Maze includes invalid characters' if c =~ /[^SG_X]/ }
      end
    end

    def validate_dimensions
      l = @map[0].length
      @map.each { |row| raise 'Maze is not rectangular' if row.length != l }
    end

    def validate_length
      raise "Maze is smaller than required" if @map.flatten.length < 2
    end

    def validate_start
      r, c = @start
      if r < 0 || c < 0 || r > @map.length-1 || c > @map[0].length-1 || @map[r][c] == 'X'
        raise 'Definition includes wrong starting point'  
      end
    end

    def validate_goal
      r, c = @goal
      if r < 0 || c < 0 || r > @map.length-1 || c > @map[0].length-1 || @map[r][c] == 'X'
        raise 'Definition includes wrong goal point'  
      end
    end

    def validate_dif_start_goal
      raise 'Start and goal cannot be the same' if @start == @goal
    end
end
