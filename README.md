# a_maze

This is a maze solving application. 

### Maze definition

Acceptable mazes consist of a rectangular array of characters:

'S' is the starting point. It can be anywhere in the matrix. Cannot be on a wall.

'G' is the goal point. It can be anywhere in the matrix apart from the starting point. Cannot be on a wall

'X' is a wall

'\_' is an open (walkable) block

Our goal is to lead an actor starting at S to G (if there exists such a path) and print the steps followed.

The actor has no idea of the maze layout beforehand (which means that fancy algorithms like A\* cannot be used!)and can only see and walk to a block directly above or below him, to his left or to his right, but not diagonally.

A maze can look like this:


       _SXX
       _XXX
       __GX

Here the upper left element would be occupying the position [0, 0], while the bottom right the position [2, 3].

Actor's path will be [[0, 0], [1, 0], [2, 0], [2, 1], [2, 2]]

### How to use this application

1. You can either a. load a maze directly (e.g. via irb) or b. save a maze definition to a file inside /mazes directory.

   a. Create the maze and set it's starting points be creating a new instance of the Maze class:
   
         maze = Maze.new([['S', 'X'], ['\_', 'G']], [0, 0], [1, 1])

   b. Load the maze directly from a file in mazes directory:

         maze = MazeLoader.load('valid_maze')

2. Create an instance of MazeSolver class:

         solver = MazeSolver.new(maze)

3. Find the path (if it exists):

         solution = solver.solve

4. If there is no path

        solution.path 
is an empty array. Else it is an array of blocks followed from S to G (S and G included).

        solution.total_steps 
returns the total number of steps taken while searching for the exit.

### The solving algorithm

The idea behind this algorithm came from reading the the [wikipedia article on maze solving algorithms](https://en.wikipedia.org/wiki/Maze_solving_algorithm). Trémaux's algorithm seemed like a perfect idea for implementation -guaranteed to find the goal, but it has one drawback: it needs to save the direction from which it has entered each block. To overcome the need for double memory, we used a step counter (number of steps walked from S to current block). This way, if an intersection is found, where all possible ways have already been visited, we know the way back to (hopefully) an intersection with unvisited blocks.

The algorithm works as follows:
1. While we are not next to the Goal 
2. Starting from a block where our actor is currently at (e.g. at Start), mark this block as visited and go to a random unvisited block next to it (actually, we traversing them in specific order, but this makes no difference).
3. If there is no univisited block next to the one you are standing mark the block you are standing on (in our case with an 'X', as a wall) and go one step backwards (to the block marked with (current_step - 1). Do that until you find an unvisited block.
4. If all blocks around you are marked as walls, there is no path to Goal.

While simple in its conception, the algorithm really works and will visit every neighbouring unvisited block before giving up! It is really that persistant!

### Tests

After navigating to the root path of the application, type:

```bundle exec rspec```