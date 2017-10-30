require_relative '../../lib/a_maze'

RSpec.describe CountingSteps do
  context 'when asked to find the goal in a solvable maze' do
    let(:maze_ar) { [['S', '_', '_', '_'], 
                     ['_', 'X', 'X', '_'],
                     ['X', 'X', 'X', 'G']]
                  }
    let(:maze_start) { [0, 0] }
    let(:maze_goal)  { [2, 3] }

    before(:each) do
      @maze   = Maze.new(maze_ar, maze_start, maze_goal)
      @solver = MazeSolver.new(@maze)
      @solution = @solver.solve
    end

    it 'returns an instance of solution with the path' do
      expect(@solution.path).to eq([[0, 0], [0, 1], [0, 2], [0, 3], [1, 3], [2, 3]])
    end

    it 'does not mutate the maze array' do
      maze_reloaded = Maze.new(maze_ar, maze_start, maze_goal)
      expect(@maze.maze_array).to eq(maze_reloaded.maze_array)
    end
  end

  context 'when asked to find the goal in an unsolvable maze' do 
    let(:maze)  { Maze.new([['S', 'X'], 
                            ['_', 'X'],
                            ['X', 'G']],
                            [0, 0],
                            [2, 1]
                          )
                }
    it 'returns an instance of solution with an empty path' do
      solver   = MazeSolver.new(maze)
      solution = solver.solve
      expect(solution.path).to eq([])
    end
  end
end