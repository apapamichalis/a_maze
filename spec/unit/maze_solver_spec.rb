require_relative '../../lib/a_maze'

RSpec.describe MazeSolver do
  context 'when creating a new instance of maze solver' do
    let(:map)   { 
                  [['S', 'X'],
                   ['_', 'G']] 
                } 
    let(:start) { [0, 0] }
    let(:goal)  { [1, 1] }

    context 'when the algorithm requested is counting steps' do
      it 'returns a new instance of counting steps' do
        maze   = Maze.new(map, goal, start)
        solver = MazeSolver.new(maze, 'counting steps')
        expect(solver).to be_an_instance_of(CountingSteps)
      end
    end

    context 'when the algorithm requested is unknown' do
      it 'returns nil' do
        maze   = Maze.new(map, goal, start)
        solver = MazeSolver.new(maze, 'another algorithm')
        expect(solver).to be_nil
      end
    end
  end
end
