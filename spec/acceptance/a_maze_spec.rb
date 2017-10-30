require_relative '../../lib/a_maze'

RSpec.describe 'A_maze' do
  before(:each) do
    @maze     = MazeLoader.load('valid_maze')
    @solver   = MazeSolver.new(@maze)
    @solution = @solver.solve
  end

  it 'finds the way out of a maze' do
    expect(@solution.path).to be_an_instance_of(Array)
    # Below is the one and only solution for this maze S->G
    expect(@solution.path).to eq(
      [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], 
       [0, 6], [1, 6], [2, 6], [3, 6], [4, 6]]
    )
  end

  it 'does not mutate the loaded maze map' do
    maze_reloaded = MazeLoader.load('valid_maze')
    expect(@maze.maze_array).to eq(maze_reloaded.maze_array)
  end
end