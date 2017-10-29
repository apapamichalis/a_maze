require_relative '../../lib/a_maze'

RSpec.describe MazeSolver do
  context 'when asked to find the goal in a solvable maze' do
    let(:maze) {Maze.new([['S', '_', '_', '_'], 
                          ['_', 'X', 'X', '_'],
                          ['X', 'X', 'X', 'G']],
                          [0, 0],
                          [2, 3]
                          )}

    it 'returns an instance of solution with the path' do
      solver   = MazeSolver.new(maze)
      solution = solver.solve
      expect(solution.path).to eq([[0, 0], [0, 1], [0, 2], [0, 3], [1, 3], [2, 3]])
    end 
  end

  context 'when asked to find the goal in an unsolvable maze' do 
    let(:maze) {Maze.new([['S', 'X'], 
                          ['_', 'X'],
                          ['X', 'G']],
                          [0, 0],
                          [2, 1]
                          )}
    it 'returns an instance of solution with an empty path' do
      solver   = MazeSolver.new(maze)
      solution = solver.solve
      expect(solution.path).to eq([])
    end
  end
end