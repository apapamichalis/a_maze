# This is the class used to create a new maze solving object
# Currently only one algorithm is supported, but can support more when needed.
class MazeSolver
  # This is the way we can use more than one solving algorithms, by adding
  # it's class definition and an extra conditional below
  # Here, self refers to the object the function is being called with
  # From https://stackoverflow.com/questions/2505067/class-self-idiom-in-ruby
  def self.build(maze, algorithm = 'counting steps')
    return CountingSteps.new(maze) if algorithm == 'counting steps'
  end
end
