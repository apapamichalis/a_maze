require_relative '../../a_maze'


RSpec.describe MazeLoader do 
  describe 'when trying to load an existing maze file' do
    context 'returns a valid maze object which' do
      before(:each) { @maze = MazeLoader.load('valid_maze') }
      
      it 'has the map of the maze as an array' do
        expect(@maze.map).to be_an(Array)

      end

      it 'has a starting point' do
        expect(@maze.start).to eq([0, 0])
      end

      it 'has a goal point' do
        expect(@maze.goal).to eq([4, 6])
      end
    end

    context 'when the file does not have a starting point' do
      it 'raises a starting point not found error' do
        expect{MazeLoader.load('no_start')}.to raise_error(/not locate S/)
      end
    end

    context 'when the file does not have a goal point' do
      it 'raises a goal point not found error' do
        expect{MazeLoader.load('no_goal')}.to raise_error(/not locate G/)
      end
    end

    context 'when the file has more than one starting points' do
      it 'raises a multiple starting points error' do
        expect{MazeLoader.load('multiple_start')}.to raise_error(/multiple S/)
      end
    end

    context 'when the file has more than one goal points' do
      it 'raises a multiple goal points error' do
        expect{MazeLoader.load('multiple_goal')}.to raise_error(/multiple G/)
      end
    end
  end
end
