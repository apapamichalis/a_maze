class MazeSolver
  def initialize(maze)
    @maze = maze
    @solution = Solution.new
  end

  def solve
    counting_steps
    return @solution
  end

  private

    # This algorithm is based on Tremaux's algorithm, but instead of retaining the entrance 
    # point(direction) for each block, we "write" on each block the steps it took us 
    # to get there from the starting point.
    # While we do not see the goal, we see if we have any move available
    # If we do, we visit the next undiscovered (unvisited) block.
    # If there are no undiscovered blocks, we move backwards, until we find an undiscovered block (intersection)
    # While moving backwards, we mark the block as walls, so that we will not revisit for a third time.
    def counting_steps
      current_position = @maze.start
      current_step = 0
      # While the goal is not within sight
      while(!see_goal(current_position)) do
        # If you still have available moves
        if available_moves(current_position)
          # If there exists a block that has not been visited yet, next to current_position
          if undiscovered_point(current_position)
            @solution.push(current_position)
            @maze.maze_array[current_position[0]][current_position[1]] = current_step
            current_step += 1
            current_position = undiscovered_point(current_position)
          # If all surrounding blocks have already been visited
          else
            # Remove this point from the solution path
            @solution.pop
            # Mark the current block as a wall, so that it never gets revisited
            @maze.maze_array[current_position[0]][current_position[1]] = 'X'
            # Move one step back
            current_position = move_backwards(current_position, current_step)
            # Keep track of the steps walked from starting point
            current_step -= 1
          end
        # If there are no moves available and exit is not within reach, it is unsolvable
        else
          @solution.flush
          return
        end
      end
      @solution.push(current_position)
      @solution.push(@maze.goal)
    end

    # Returns true if Goal is either above, below, to the left or to the right of 
    # the current position, but not diagonally, hence the XOR
    def see_goal(current_position)
      cur_r = current_position[0]
      cur_c = current_position[1]
      return true if ((cur_r - @maze.goal[0]).abs == 1) && (cur_c == @maze.goal[1])
      return true if ((cur_c - @maze.goal[1]).abs == 1) && (cur_r == @maze.goal[0])        
      return false
    end

    # Returns true unless the way in every direction is blocked by a wall
    def available_moves(current_position)
      cur_r = current_position[0]
      cur_c = current_position[1]
      return true unless @maze.maze_array[cur_r + 1][cur_c] == 'X' || outside_limits([cur_r + 1, cur_c])
      return true unless @maze.maze_array[cur_r - 1][cur_c] == 'X' || outside_limits([cur_r - 1, cur_c])
      return true unless @maze.maze_array[cur_r][cur_c + 1] == 'X' || outside_limits([cur_r, cur_c + 1])
      return true unless @maze.maze_array[cur_r][cur_c - 1] == 'X' || outside_limits([cur_r, cur_c - 1])
      return false
    end

    # Returns the coordinates of the next undiscovered point if it exists
    def undiscovered_point(current_position)
      cur_r = current_position[0]
      cur_c = current_position[1]
      return [cur_r + 1, cur_c] if @maze.maze_array[cur_r + 1][cur_c] == '_' && !outside_limits([cur_r + 1, cur_c])
      return [cur_r - 1, cur_c] if @maze.maze_array[cur_r - 1][cur_c] == '_' && !outside_limits([cur_r - 1, cur_c])
      return [cur_r, cur_c + 1] if @maze.maze_array[cur_r][cur_c + 1] == '_' && !outside_limits([cur_r, cur_c + 1])
      return [cur_r, cur_c - 1] if @maze.maze_array[cur_r][cur_c - 1] == '_' && !outside_limits([cur_r, cur_c - 1])
      return false
    end

    # Check if a point is outside the maze array
    def outside_limits(point)
      outside = false
      outside = true if point[0] > @maze.maze_array.length - 1    || point[0] < 0
      outside = true if point[1] > @maze.maze_array[0].length - 1 || point[1] < 0
      return outside
    end

    # Returns the previous block we were at.
    def move_backwards(current_position, current_step)
      cur_r = current_position[0]
      cur_c = current_position[1]
      return [cur_r + 1, cur_c] if @maze.maze_array[cur_r + 1][cur_c] == current_step - 1
      return [cur_r - 1, cur_c] if @maze.maze_array[cur_r - 1][cur_c] == current_step - 1
      return [cur_r, cur_c + 1] if @maze.maze_array[cur_r][cur_c + 1] == current_step - 1
      return [cur_r, cur_c - 1] if @maze.maze_array[cur_r][cur_c - 1] == current_step - 1
    end
end