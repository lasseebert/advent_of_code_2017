defmodule Advent.Dec11 do
  @moduledoc """
  --- Day 11: Hex Ed ---

  Crossing the bridge, you've barely reached the other side of the stream when a program comes up to you, clearly in distress. "It's my child process," she says, "he's gotten lost in an infinite grid!"

  Fortunately for her, you have plenty of experience with infinite grids.

  Unfortunately for you, it's a hex grid.

  The hexagons ("hexes") in this grid are aligned such that adjacent hexes can be found to the north, northeast, southeast, south, southwest, and northwest:

  \ n  /
  nw +--+ ne
  /    \
  -+      +-
  \    /
  sw +--+ se
  / s  \
  You have the path the child process took. Starting where he started, you need to determine the fewest number of steps required to reach him. (A "step" means to move from the hex you are in to any adjacent hex.)

  For example:

  ne,ne,ne is 3 steps away.
  ne,ne,sw,sw is 0 steps away (back where you started).
  ne,ne,s,s is 2 steps away (se,se).
  se,sw,se,sw,sw is 3 steps away (s,s,sw).
  """

  @default_input_path "inputs/dec_11"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  require Integer

  def num_steps(input \\ @default_input) do
    input
    |> parse
    |> coords
    |> Tuple.to_list
    |> Enum.map(&abs/1)
    |> Enum.max
  end

  defp coords(dirs) do
    dirs
    |> Enum.reduce({0, 0}, fn dir, coord ->
      move(coord, dir)
    end)
  end

  defp move({x, y}, :n), do: {x, y + 1}
  defp move({x, y}, :s), do: {x, y - 1}

  defp move({x, y}, :ne) when Integer.is_even(x), do: {x + 1, y}
  defp move({x, y}, :ne), do: {x + 1, y + 1}
  defp move({x, y}, :se) when Integer.is_even(x), do: {x + 1, y - 1}
  defp move({x, y}, :se), do: {x + 1, y}

  defp move({x, y}, :sw) when Integer.is_even(x), do: {x - 1, y - 1}
  defp move({x, y}, :sw), do: {x - 1, y}
  defp move({x, y}, :nw) when Integer.is_even(x), do: {x - 1, y}
  defp move({x, y}, :nw), do: {x - 1, y + 1}

  defp parse(input) do
    input
    |> String.trim
    |> String.split(",")
    |> Enum.map(fn
      dir when dir in ~w[n ne se s sw nw] -> dir |> String.to_atom
    end)
  end
end
