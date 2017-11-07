# Creates a Maze object from a maze file. Mazes have to be stored in 
# ../mazes directory
class MazeLoader

  def self.load(filename)
    # Get the absolute path of the maze file inside ../mazes/ directory
    fullpath = File.join(File.dirname(__FILE__), '../mazes/') + filename

    # Read the valid characters from file and enter them into a
    # two-dimensional array. Only accepts valid characters:
    # _:empty block, X: wall, G: goal, S: start 
    maze_array = File.foreach(fullpath).map { |line| line.scan(/[_XGS]/) }
    Maze.new(maze_array)
  end
end
