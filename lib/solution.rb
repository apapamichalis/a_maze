# MazeSolver creates an instance of Solution
# Every forward step is a push every backward step is a pop
# If the maze is unsolvable the path array is flushed
# The total_steps keeps track of the steps taken, when trying to solve this maze

class Solution
  attr_reader :path
  attr_reader :total_steps

  def initialize
    @path = []
    @total_steps = 0
  end

  def push(e)
    @path.push(e)
    @total_steps += 1
  end

  def pop
    @path.pop
    @total_steps += 1
  end

  def flush
    @path = []
  end 
end