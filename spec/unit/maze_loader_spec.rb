require_relative '../../lib/a_maze'

RSpec.describe MazeLoader do 
  describe 'when trying to load an existing maze file' do
    context 'returns a valid maze object which' do
      before(:each) { @maze = MazeLoader.load('valid_maze') }

      it 'has the map of the maze as an array' do
        expect(@maze.maze_array).to be_an(Array)
      end

      it 'has a starting point' do
        expect(@maze.start).to eq([0, 0])
      end

      it 'has a goal point' do
        expect(@maze.goal).to eq([4, 6])
      end
    end
  end
end
