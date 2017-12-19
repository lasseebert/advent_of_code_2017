defmodule Advent.Dec19 do
  @moduledoc """
  --- Day 19: A Series of Tubes ---

  Somehow, a network packet got lost and ended up here. It's trying to follow a routing diagram (your puzzle input), but it's confused about where to go.

  Its starting point is just off the top of the diagram. Lines (drawn with |, -, and +) show the path it needs to take, starting by going down onto the only line connected to the top of the diagram. It needs to follow this path until it reaches the end (located somewhere within the diagram) and stop there.

  Sometimes, the lines cross over each other; in these cases, it needs to continue going the same direction, and only turn left or right when there's no other option. In addition, someone has left letters on the line; these also don't change its direction, but it can use them to keep track of where it's been. For example:

       |          
       |  +--+    
       A  |  C    
   F---|----E|--+ 
       |  |  |  D 
       +B-+  +--+ 

  Given this diagram, the packet needs to take the following path:

  Starting at the only line touching the top of the diagram, it must go down, pass through A, and continue onward to the first +.
  Travel right, up, and right, passing through B in the process.
  Continue down (collecting C), right, and up (collecting D).
  Finally, go all the way left through E and stopping at F.
  Following the path to the end, the letters it sees on its path are ABCDEF.

  The little packet looks up at you, hoping you can help it find the way. What letters will it see (in the order it would see them) if it follows the path? (The routing diagram is very wide; make sure you view it without line wrapping.)
  """

  @default_input_path "inputs/dec_19"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  def find_letters(input \\ @default_input) do
    input
    |> start
    |> elem(0)
    |> Enum.join
  end

  def count_steps(input \\ @default_input) do
    input
    |> start
    |> elem(1)
  end

  defp start(input) do
    map = input |> parse
    start_point = map |> Map.keys |> Enum.find(fn {_x, y} = coord -> y == 0 and Map.get(map, coord) == "|" end)

    map |> walk(:south, start_point, [], 0)
  end

  defp walk(map, dir, coord, letters, steps) do
    if Map.has_key?(map, coord) do
      do_walk(map, dir, coord, letters, steps)
    else
      {letters |> Enum.reverse, steps}
    end
  end

  defp do_walk(map, dir, coord, letters, steps) do
    current = map |> Map.fetch!(coord)
    letters = if current |> String.match?(~r/[a-zA-Z]/), do: [current | letters], else: letters
    next_dir = search_next_dir(map, dir, coord, current)

    map
    |> walk(next_dir, next_coord(coord, next_dir), letters, steps + 1)
  end

  defp search_next_dir(map, dir, coord, "+") when dir in [:south, :north], do: search_dir(:east_west, map, coord)
  defp search_next_dir(map, dir, coord, "+") when dir in [:east, :west], do: search_dir(:north_south, map, coord)
  defp search_next_dir(_, dir, _, _), do: dir

  defp search_dir(:east_west, map, {x, y}) do
    cond do
      Map.has_key?(map, {x - 1, y}) -> :west
      Map.has_key?(map, {x + 1, y}) -> :east
    end
  end
  defp search_dir(:north_south, map, {x, y}) do
    cond do
      Map.has_key?(map, {x, y - 1}) -> :north
      Map.has_key?(map, {x, y + 1}) -> :south
    end
  end

  defp next_coord({x, y}, :east), do: {x + 1, y}
  defp next_coord({x, y}, :west), do: {x - 1, y}
  defp next_coord({x, y}, :south), do: {x, y + 1}
  defp next_coord({x, y}, :north), do: {x, y - 1}

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {line, row_index}, map ->
      line
      |> String.graphemes
      |> Enum.with_index
      |> Enum.reduce(map, fn
        {" ", _}, map ->
          map
        {char, col_index}, map ->
          Map.put(map, {col_index, row_index}, char)
      end)
    end)
  end
end
