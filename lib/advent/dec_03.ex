defmodule Advent.Dec03 do
  @moduledoc """
  --- Day 3: Spiral Memory ---

  You come across an experimental new kind of memory stored on an infinite two-dimensional grid.

  Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...
  While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

  For example:

  Data from square 1 is carried 0 steps, since it's at the access port.
  Data from square 12 is carried 3 steps, such as: down, left, left.
  Data from square 23 is carried only 2 steps: up twice.
  Data from square 1024 must be carried 31 steps.
  How many steps are required to carry the data from the square identified in your puzzle input all the way to the access port?

  Your puzzle input is 312051.

  --- Part Two ---

  As a stress test on the system, the programs here clear the grid and then store the value 1 in square 1. Then, in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

  So, the first few squares' values are chosen as follows:

  Square 1 starts with the value 1.
  Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
  Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
  Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
  Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.
  Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

  147  142  133  122   59
  304    5    4    2   57
  330   10    1    1   54
  351   11   23   25   26
  362  747  806--->   ...
  What is the first value written that is larger than your puzzle input?

  Your puzzle input is still 312051.
  """

  @default_square 312051

  def run(n \\ @default_square) do
    {x, y} = find_coords(n)
    abs(x) + abs(y)
  end

  def run_2(n \\ @default_square) do
    sum_squares()
    |> Enum.find(fn k -> k > n end)
  end

  defp find_coords(n) do
    find_coords(n, 1, {0, 0}, {1, :right})
  end

  def find_coords(n, k, coords, {count, _dir} = step) when n - k > count do
    find_coords(n, k + count, next_coords(coords, step), next_step(step))
  end
  def find_coords(n, k, coords, {_count, dir}) do
    next_coords(coords, {n - k, dir})
  end

  def next_coords({x, y}, {count, :up}), do: {x, y + count}
  def next_coords({x, y}, {count, :down}), do: {x, y - count}
  def next_coords({x, y}, {count, :left}), do: {x - count, y}
  def next_coords({x, y}, {count, :right}), do: {x + count, y}

  defp next_step({count, :right}), do: {count, :up}
  defp next_step({count, :up}), do: {count + 1, :left}
  defp next_step({count, :left}), do: {count, :down}
  defp next_step({count, :down}), do: {count + 1, :right}

  defp sum_squares do
    Stream.unfold({%{}, 1, {0, 0}, {0, :no_dir}, {1, :right}}, &next_sum_square/1)
  end

  defp next_sum_square({grid, n, coords, {0, _dir}, step}) do
    next_sum_square({grid, n, coords, step, next_step(step)})
  end
  defp next_sum_square({grid, n, coords, {count, dir}, step}) do
    grid = Map.put(grid, coords, n)
    {x, y} = n_coords = next_coords(coords, {1, dir})
    next_n = [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
    |> Enum.map(&Map.get(grid, &1, 0))
    |> Enum.sum
    {n, {grid, next_n, n_coords, {count - 1, dir}, step}}
  end
end
