# ice_nine is a gem, with which one deep freezes recursively ruby objects.
require 'ice_nine'
# Holds the definition of a valid Maze object
#
# A valid maze object consists of a two-dimensional array (the maze),
# the starting point of the maze and a goal point of the maze
class Maze
  attr_reader :maze_array
  attr_reader :start
  attr_reader :goal

  def initialize(maze_array)
    @maze_array = IceNine.deep_freeze(maze_array)
    start       = locate(@maze_array, 'S')
    goal        = locate(@maze_array, 'G')
    validate_maze
    @start      = IceNine.deep_freeze(start)
    @goal       = IceNine.deep_freeze(goal)
  end

  private

    # Returns the location of str (starting or goal point) it finds on a maze_array.
    # If the maze_array has multiple starting or goal points, it will raise an error.
    # If the maze_array has no starting or no goal point, it will raise an error.
    def locate(maze_array, str)
      result = nil
      maze_array.each_with_index do |line, r|
        line.each_with_index do |char, c|
          if char == str
            raise "Expected 1. Found multiple #{str}" unless result.nil?
            result = [r, c]
          end
        end
      end
      raise "Could not locate #{str} on maze file given." if result.nil?
      result
    end

    def validate_maze
      validate_dimensions
      validate_characters
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
end
