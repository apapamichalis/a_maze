class MazeLoader
  class << self

    # With validations = false, the Maze constructor will not validate 
    # the data it is passed. 
    # 
    def load(filename, validations = true)
      # Get the absolute path of the maze file inside ../mazes/ directory
      fullpath = File.join(File.dirname(__FILE__), '../mazes/') + filename
      
      # Read the valid characters from file and enter them into a 
      # two-dimensional array. Only accepts valid characters:
      # _:empty block, X: wall, G: goal, S: start 
      maze_array = File.foreach(fullpath).map { |line| line.scan(/[_XGS]/) } 
      start = locate(maze_array, 'S')
      goal  = locate(maze_array, 'G')
      Maze.new(maze_array, start, goal, validations)
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
  end
end