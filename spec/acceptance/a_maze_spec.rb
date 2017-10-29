require_relative '../../a_maze'

RSpec.describe 'A_maze' do
  it 'finds the way out of a maze' do
    pending 'nothing implemented yet'
    maze     = MazeLoader.load('valid_maze')
    solver   = MazeSolver.new(maze)
    solution = solver.solve
    expect(solution.moves).to be_an_instance_of(Array)
    # Below is the one and only solution for this maze S->G
    expect(solution.moves).to eq(
      [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], 
              [0, 6], [1, 6], [2, 6], [3, 6], [4, 6]]
    )
  end
end