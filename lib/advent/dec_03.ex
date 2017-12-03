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
  """

  @default_square 312051

  def run(n \\ @default_square) do
    {x, y} = find_coords(n)
    abs(x) + abs(y)
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
end
