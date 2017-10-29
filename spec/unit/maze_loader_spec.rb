require_relative '../../a_maze'

RSpec.describe MazeLoader do 
  describe 'when trying to load an existing maze file' do
    context 'returns a valid maze object which' do
      before(:each) { @maze = MazeLoader.load('valid_maze') }
      
      it 'has a starting point' do
        expect(@maze.start).to_not be_empty
      end

      it 'has a goal point' do
        expect(@maze.goal).to_not be_empty
      end
    end

    context 'when the file does not have a starting point' do
      it 'raises a starting point not found error' do
        expect(MazeLoader.load('no_start')).to raise_error(/starting point/)
      end
    end

    context 'when the file does not have a goal point' do
      it 'raises a goal point not found error' do
        expect(MazeLoader.load('no_goal')).to raise_error(/goal point/)
      end
    end

    context 'when the file has more than one starting points' do
      it 'raises a multiple starting points error' do
        expect(MazeLoader.load('multiple_S')).to raise_error(/multiple start/)
      end
    end

    context 'when the file has more than one goal points' do
      it 'raises a multiple goal points error' do
        expect(MazeLoader.load('multiple_G')).to raise_error(/multiple goal/)
      end
    end
  end
    
  describe 'when trying to load a not-existing file' do
    it 'raises en Errno error' do
      expect(MazeLoader.load('not_existing_file')).to raise_error(/Errno/)
    end
  end
end
