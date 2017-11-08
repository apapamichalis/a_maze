require_relative '../../lib/a_maze'

RSpec.describe Solution do
  context 'when pushing a new point (moving forward)' do
    before(:each) do 
      @solution = Solution.new
      @solution.push([0, 0])
      @solution.push([0, 1])
    end

    it 'retains it' do
      expect(@solution.path).to eq([[0, 0], [0, 1]])
    end

    it 'counts the total number of steps taken' do
      expect(@solution.total_steps).to eq(2)
      @solution.push([1, 1])
      expect(@solution.total_steps).to eq(3)
    end
  end

  context 'when popping a point (moving backwards)' do
    before(:each) do 
      @solution = Solution.new
      @solution.push([0, 0])
      @solution.pop
    end

    it 'removes it' do
      expect(@solution.path).to eq([])
    end

    it 'counts the total number of steps taken (forwards and backwards' do
      expect(@solution.total_steps).to eq(2)
    end

    it 'does not keeping counting when the path is empty and popping' do
      @solution.pop
      expect(@solution.total_steps).to eq(2)
    end

    it 'returns the coordinates of the previous block' do
      @solution.push([3, 5])
      previous = @solution.pop
      expect(previous).to eq([3, 5])
    end
  end

  context 'when the maze is unsolvable we flush it and' do
    before(:each) do 
      @solution = Solution.new
      @solution.push([0, 0])
      @solution.push([0, 1])
      @solution.flush
    end

    it 'retains the total number of steps taken' do
      expect(@solution.total_steps).to eq(2)
    end

    it 'does not hold a path' do
      expect(@solution.path).to eq([])
    end
  end
end



