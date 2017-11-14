# A maze solving implementation that sits between Tremaux's algorithm
# and a DFS
class CountingSteps
  # Duplicating the maze, because our algorithm needs to mutate it
  def initialize(maze)
    @maze_array = duplicate_maze(maze)
    @start = maze.start
    @goal  = maze.goal
    @solution = Solution.new
  end

  def solve
    counting_steps
    @solution
  end

  private

  # This algorithm is based on Tremaux's algorithm, but instead of retaining
  # the entrance point(direction) for each block, we "write" on each block the
  # steps it took us to get there from the starting point.
  # While we do not see the goal, we see if we have any move available
  # If we do, we visit the next undiscovered (unvisited) block.
  # If there are no undiscovered blocks, we move backwards, until we find an
  # undiscovered block (intersection)
  # While moving backwards, we mark the block as walls, so that we will not
  # revisit for a third time.
  def counting_steps
    current_position = @start
    current_step = 0
    # While the goal is not within sight
    until on_goal(current_position)
      # If you still have available moves
      if available_moves?(current_position)
        # If there exists a block that has not been visited yet, next to current_position
        if undiscovered_point(current_position)
          # Push the current position to the path followed
          @solution.push(current_position)
          # Mark this position as visited
          @maze_array[current_position[0]][current_position[1]] = current_step
          current_step += 1
          # Move to the next undiscovered position
          current_position = undiscovered_point(current_position)
        # If all surrounding blocks have already been visited
        else
          # Mark the current block as a wall, so that it never gets revisited
          @maze_array[current_position[0]][current_position[1]] = 'X'
          # # Remove this point from the solution path and move one step back
          current_position = move_backwards
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
  end

  # Returns true if Goal is either above, below, to the left or to the right of 
  # the current position, but not diagonally
  def on_goal(current_position)
    row = current_position[0]
    col = current_position[1]
    @maze_array[row][col] == 'G'
  end

  # Returns true unless the way in every direction is blocked by a wall or the outter bounds of the maze
  def available_moves?(current_position)
    row = current_position[0]
    col = current_position[1]
    valid_move?(row + 1, col) || valid_move?(row - 1, col) ||
      valid_move?(row, col + 1) || valid_move?(row, col - 1)
  end

  # Returns true if stepping on those coordinates is a valid move
  def valid_move?(row, col)
    !a_wall?(row, col) && inside_maze?(row, col)
  end

  # Returns true if a point is a wall
  def a_wall?(row, col)
    @maze_array[row][col] == 'X'
  end

  # Check if point is inside maze
  def inside_maze?(row, col)
    row >= 0 && row < @maze_array.length && col >= 0 && col < @maze_array[0].length
  end

  # Return true if a point is undiscovered
  def empty_point?(row, col)
    @maze_array[row][col] =~ /[_G]/
  end

  # Returns the coordinates of the next undiscovered point if it exists
  def undiscovered_point(current_position)
    row = current_position[0]
    col = current_position[1]
    return [row + 1, col] if empty_point?(row + 1, col) && inside_maze?(row + 1, col)
    return [row - 1, col] if empty_point?(row - 1, col) && inside_maze?(row - 1, col)
    return [row, col + 1] if empty_point?(row, col + 1) && inside_maze?(row, col + 1)
    return [row, col - 1] if empty_point?(row, col - 1) && inside_maze?(row, col - 1)
  end

  # Returns the previous block the actor was at.
  def move_backwards
    @solution.pop
  end

  # Duplicating in this way, because of original array being deep frozen and we need
  # a mutable maze map
  def duplicate_maze(m)
    m.maze_array.each.each.map(&:dup)
  end
end
