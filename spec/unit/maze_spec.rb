require_relative '../../lib/maze'

RSpec.describe Maze do 
  describe 'when creating a valid maze object' do
    let(:map)   { 
                  [['S', 'X'],
                   ['_', 'G']] 
                } 
    let(:start) { [0, 0] }
    let(:goal)  { [1, 1] }
               
    context 'it returns a valid maze object which' do
      before(:each) { @maze = Maze.new(map, start, goal) }
      
      it 'has the correct maze map' do
        expect(@maze.map).to eq(map)
      end

      it 'has the correct starting point' do
        expect(@maze.start).to eq(start)
      end

      it 'has the correct goal point' do
        expect(@maze.goal).to eq(goal)
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
        expect(Maze.new(map, start, goal)).to raise_error(/not rectangular/)
      end
    end

    context 'which has a map smaller than 2 blocks' do
      let(:map)   { ['S']  } 
      let(:start) { [0, 0] }
      let(:goal)  { [0, 0] }
            
      it 'raises a map smaller than required' do
        expect(Maze.new(map, start, goal)).to raise_error(/smaller than required/)
      end
    end

    context 'which has a starting point outside map' do
      let(:map)   { 
                    [['_', 'X'],
                     ['_', 'G']] 
                  } 
      let(:start) { [2, 3] }
      let(:goal)  { [1, 1] }

      it 'raises a wrong starting point error' do
        expect(Maze.new(map, start, goal)).to raise_error(/wrong starting/)
      end
    end

    context 'which has a starting point on a wall' do
      let(:map)   { 
                    [['_', 'X'],
                     ['_', 'G']] 
                  } 
      let(:start) { [0, 1] }
      let(:goal)  { [1, 1] }

      it 'raises a wrong starting point error' do
        expect(Maze.new(map, start, goal)).to raise_error(/wrong starting/)
      end
    end

    context 'which has a goal point outside map' do
      let(:map)   { 
                    [['S', 'X'],
                     ['_', '_']] 
                  } 
      let(:start) { [0, 0] }
      let(:goal)  { [2, 3] }

      it 'raises a wrong goal point error' do
        expect(Maze.new(map, start, goal)).to raise_error(/wrong goal/)
      end
    end

    context 'which has a goal point on a wall' do
      let(:map)   { 
                    [['S', 'X'],
                     ['_', '_']] 
                  } 
      let(:start) { [0, 0] }
      let(:goal)  { [0, 1] }

      it 'raises a wrong goal point error' do
        expect(Maze.new(map, start, goal)).to raise_error(/wrong goal/)
      end
    end

    context 'which has the same point as start and goal' do
      let(:map)   { 
                    [['_', 'X'],
                     ['_', '_']] 
                  } 
      let(:start) { [0, 0] }
      let(:goal)  { [0, 0] }

      it 'raises a wrong goal point error' do
        expect(Maze.new(map, start, goal)).to raise_error(/wrong goal/)
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
        expect(Maze.new(map, start, goal)).to raise_error(/invalid characters/)
      end
    end
  end
end
