require_relative '../../lib/a_maze'

RSpec.describe CountingSteps do
  context 'when asked to find the goal in a solvable maze' do
    let(:maze_ar) { [['S', '_', '_', '_'], 
                     ['_', 'X', 'X', '_'],
                     ['X', 'X', 'X', 'G']]
                  }

    before(:each) do
      @maze   = Maze.new(maze_ar)
      @solver = MazeSolver.build(@maze)
      @solution = @solver.solve
    end

    it 'returns an instance of solution with the path' do
      expect(@solution.path).to eq([[0, 0], [0, 1], [0, 2], [0, 3], [1, 3], [2, 3]])
    end
  end

  context 'when asked to find the goal in an unsolvable maze' do 
    let(:maze)  { Maze.new([['S', 'X'], 
                            ['_', 'X'],
                            ['X', 'G']],
                          )
                }
    it 'returns an instance of solution with an empty path' do
      solver   = MazeSolver.build(maze)
      solution = solver.solve
      expect(solution.path).to eq([])
    end
  end
end
