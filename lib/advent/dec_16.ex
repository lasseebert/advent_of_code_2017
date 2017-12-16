defmodule Advent.Dec16 do
  @moduledoc """
  --- Day 16: Permutation Promenade ---

  You come upon a very unusual sight; a group of programs here appear to be dancing.

  There are sixteen programs in total, named a through p. They start by standing in a line: a stands in position 0, b stands in position 1, and so on until p, which stands in position 15.

  The programs' dance consists of a sequence of dance moves:

  Spin, written sX, makes X programs move from the end to the front, but maintain their order otherwise. (For example, s3 on abcde produces cdeab).
  Exchange, written xA/B, makes the programs at positions A and B swap places.
  Partner, written pA/B, makes the programs named A and B swap places.
  For example, with only five programs standing in a line (abcde), they could do the following dance:

  s1, a spin of size 1: eabcd.
  x3/4, swapping the last two programs: eabdc.
  pe/b, swapping programs e and b: baedc.
  After finishing their dance, the programs end up in order baedc.

  You watch the dance for a while and record their dance moves (your puzzle input). In what order are the programs standing after their dance?
  """

  @default_input_path "inputs/dec_16"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  @default_programs "abcdefghijklmnop"

  def dance(programs \\ @default_programs, moves \\ parse_moves(@default_input)) do
    moves
    |> Enum.reduce(programs, &single_move(&2, &1))
  end

  def parse_moves(input) do
    input
    |> String.trim
    |> String.split(",")
    |> Enum.map(&parse_move/1)
  end

  defp single_move(programs, {:spin, size}) do
    programs
    |> String.split_at(String.length(programs) - size)
    |> Tuple.to_list
    |> Enum.reverse
    |> Enum.join
  end
  defp single_move(programs, {:exchange, index_a, index_b}) do
    [index_a, index_b] = [index_a, index_b] |> Enum.sort
    {first, <<a, rest::binary>>} = programs |> String.split_at(index_a)
    {second, <<b, third::binary>>} = rest |> String.split_at(index_b - index_a - 1)
    <<first::binary, b, second::binary, a, third::binary>>
  end
  defp single_move(programs, {:partner, a, b}) do
    programs
    |> String.graphemes
    |> Enum.reduce("", fn
      ^a, result -> result <> b
      ^b, result -> result <> a
      x, result -> result <> x
    end)
  end

  defp parse_move("s" <> size) do
    {:spin, String.to_integer(size)}
  end
  defp parse_move("x" <> rest) do
    [a, b] = rest |> String.split("/") |> Enum.map(&String.to_integer/1)
    {:exchange, a, b}
  end
  defp parse_move(<<"p", a, "/", b>>) do
    {:partner, <<a>>, <<b>>}
  end
end
