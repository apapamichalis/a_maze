class CountingSteps
  def initialize(maze)
    # Duplicating the maze, because our algorithm mutates it
    # It is memory-inefficient, but allows us to use the same maze object
    # with different algorithms if needed.
    @maze = Marshal.load(Marshal.dump(maze))
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
          if !!undiscovered_point(current_position)
            # Push the current position to the path followed
            @solution.push(current_position)
            # Mark this position as visited
            @maze.maze_array[current_position[0]][current_position[1]] = current_step
            current_step += 1
            # Move to the next undiscovered position
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
    # the current position, but not diagonally
    def see_goal(current_position)
      row = current_position[0]
      col = current_position[1]
      return true if ((row - @maze.goal[0]).abs == 1) && (col == @maze.goal[1])
      return true if ((col - @maze.goal[1]).abs == 1) && (row == @maze.goal[0])        
      return false
    end

    # Returns true unless the way in every direction is blocked by a wall or the outter bounds of the maze
    def available_moves(current_position)
      row = current_position[0]
      col = current_position[1]
      return true unless invalid_move?(row + 1, col)
      return true unless invalid_move?(row - 1, col)
      return true unless invalid_move?(row, col + 1)
      return true unless invalid_move?(row, col - 1)
      return false
    end

    # Returns true if stepping on those coordinates is an invalid move
    def invalid_move?(row, col)
      return is_a_wall?(row, col) || outside_limits?(row, col)
    end

    # Returns true if a point is a wall
    def is_a_wall?(row, col)
      return true if @maze.maze_array[row][col] == 'X'
      return false
    end

    # Check if a point is outside the maze array
    def outside_limits?(row, col)
      outside = false
      outside = true if row > @maze.maze_array.length - 1    || row < 0
      outside = true if col > @maze.maze_array[0].length - 1 || col < 0
      return outside
    end

    # Return true if a point is undiscovered
    def empty_point?(row, col)
      return true if @maze.maze_array[row][col] == '_'
      return false
    end

    # Returns the coordinates of the next undiscovered point if it exists
    def undiscovered_point(current_position)
      row = current_position[0]
      col = current_position[1]
      return [row + 1, col] if empty_point?(row + 1, col) && !outside_limits?(row + 1, col)
      return [row - 1, col] if empty_point?(row - 1, col) && !outside_limits?(row - 1, col)
      return [row, col + 1] if empty_point?(row, col + 1) && !outside_limits?(row, col + 1)
      return [row, col - 1] if empty_point?(row, col - 1) && !outside_limits?(row, col - 1)
      return false
    end

    # Returns the previous block we were at.
    def move_backwards(current_position, current_step)
      row = current_position[0]
      col = current_position[1]
      return [row + 1, col] if @maze.maze_array[row + 1][col] == current_step - 1
      return [row - 1, col] if @maze.maze_array[row - 1][col] == current_step - 1
      return [row, col + 1] if @maze.maze_array[row][col + 1] == current_step - 1
      return [row, col - 1] if @maze.maze_array[row][col - 1] == current_step - 1
    end
end