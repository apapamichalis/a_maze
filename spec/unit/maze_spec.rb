require_relative '../../lib/a_maze'

RSpec.describe Maze do 
  describe 'when creating a valid maze object' do
    let(:map)   { 
                  [['S', 'X'],
                   ['_', 'G']] 
                } 
    let(:start) { [0, 0] }
    let(:goal)  { [1, 1] }

    context 'it returns a valid maze object which' do
      before(:each) { @maze = Maze.new(map) }

      it 'has the correct maze map' do
        expect(@maze.maze_array).to eq(map)
      end

      it 'has the correct starting point' do
        expect(@maze.start).to eq(start)
      end

      it 'has the correct goal point' do
        expect(@maze.goal).to eq(goal)
      end

      it 'has an immutable array' do
        maze_ar = @maze.maze_array
        expect(maze_ar).to be_frozen
      end

      it 'has an immutable starting point' do
        start = @maze.start
        expect(start).to be_frozen
      end

      it 'has an immutable goal point' do
        goal = @maze.goal
        expect(goal).to be_frozen
      end
    end
  end

  describe 'when attempting to create an invalid maze object' do
    context 'which has a non-rectangular maze' do
      let(:map)   { 
                    [['S','X'],
                     ['G'    ]]
                  }
      let(:start) { [0, 0] }
      let(:goal)  { [1, 0] }

      it 'raises a not rectangular error' do
        expect{ Maze.new(map) }.to raise_error(/not rectangular/)
      end
    end

    context 'which includes invalid characters' do
      let(:map)   {
                    [['S', 'X'],
                     ['a', 'G']]
                  }
      let(:start) { [0, 0] }
      let(:goal)  { [1, 1] }

      it 'raises an invalid characters error' do
        expect{ Maze.new(map) }.to raise_error(/invalid characters/)
      end
    end

    context 'when the maze does not have a starting point' do
      let(:map)   {
        [['X', 'X'],
         ['_', 'G']]
      }

      it 'raises a starting point not found error' do
        expect { Maze.new(map) }.to raise_error(/not locate S/)
      end
    end

    context 'when the maze does not have a goal point' do
      let(:map)   {
        [['S', 'X'],
         ['X', '_']]
      }

      it 'raises a goal point not found error' do
        expect { Maze.new(map) }.to raise_error(/not locate G/)
      end
    end

    context 'when the maze has more than one starting points' do
      let(:map)   {
        [['S', 'S'],
         ['_', 'G']]
      }
      it 'raises a multiple starting points error' do
        expect{ Maze.new(map) }.to raise_error(/multiple S/)
      end
    end

    context 'when the maze has more than one goal points' do
      let(:map)   {
        [['S', 'X'],
         ['G', 'G']]
      }
      it 'raises a multiple goal points error' do
        expect{ Maze.new(map) }.to raise_error(/multiple G/)
      end
    end
  end
end
