defmodule Advent.Dec21 do
  @moduledoc """
  --- Day 21: Fractal Art ---

  You find a program trying to generate some art. It uses a strange process that involves repeatedly enhancing the detail of an image through a set of rules.

  The image consists of a two-dimensional square grid of pixels that are either on (#) or off (.). The program always begins with this pattern:

  .#.
  ..#
  ###
  Because the pattern is both 3 pixels wide and 3 pixels tall, it is said to have a size of 3.

  Then, the program repeats the following process:

  If the size is evenly divisible by 2, break the pixels up into 2x2 squares, and convert each 2x2 square into a 3x3 square by following the corresponding enhancement rule.
  Otherwise, the size is evenly divisible by 3; break the pixels up into 3x3 squares, and convert each 3x3 square into a 4x4 square by following the corresponding enhancement rule.
  Because each square of pixels is replaced by a larger one, the image gains pixels and so its size increases.

  The artist's book of enhancement rules is nearby (your puzzle input); however, it seems to be missing rules. The artist explains that sometimes, one must rotate or flip the input pattern to find a match. (Never rotate or flip the output pattern, though.) Each pattern is written concisely: rows are listed as single units, ordered top-down, and separated by slashes. For example, the following rules correspond to the adjacent patterns:

  ../.#  =  ..
            .#

                  .#.
  .#./..#/###  =  ..#
                  ###

                          #..#
  #..#/..../#..#/.##.  =  ....
                          #..#
                          .##.
  When searching for a rule to use, rotate and flip the pattern as necessary. For example, all of the following patterns match the same rule:

  .#.   .#.   #..   ###
  ..#   #..   #.#   ..#
  ###   ###   ##.   .#.
  Suppose the book contained the following two rules:

  ../.# => ##./#../...
  .#./..#/### => #..#/..../..../#..#
  As before, the program begins with this pattern:

  .#.
  ..#
  ###
  The size of the grid (3) is not divisible by 2, but it is divisible by 3. It divides evenly into a single square; the square matches the second rule, which produces:

  #..#
  ....
  ....
  #..#
  The size of this enhanced grid (4) is evenly divisible by 2, so that rule is used. It divides evenly into four squares:

  #.|.#
  ..|..
  --+--
  ..|..
  #.|.#
  Each of these squares matches the same rule (../.# => ##./#../...), three of which require some flipping and rotation to line up with the rule. The output for the rule is the same in all four cases:

  ##.|##.
  #..|#..
  ...|...
  ---+---
  ##.|##.
  #..|#..
  ...|...
  Finally, the squares are joined into a new grid:

  ##.##.
  #..#..
  ......
  ##.##.
  #..#..
  ......
  Thus, after 2 iterations, the grid contains 12 pixels that are on.

  How many pixels stay on after 5 iterations?

  --- Part Two ---

  How many pixels stay on after 18 iterations?
  """

  @default_input_path "inputs/dec_21"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  @default_iterations 5

  defmodule Image do
    defstruct [:map, :size]

    def new(map, size) do
      %__MODULE__{map: map, size: size}
    end

    def parse(pattern) do
      rows = pattern |> String.split("/")
      map =
        rows
        |> Enum.with_index
        |> Enum.reduce(%{}, fn {row, row_index}, map ->
          row
          |> String.graphemes
          |> Enum.with_index
          |> Enum.reduce(map, fn
            {".", col_index}, map -> Map.put(map, {col_index, row_index}, false)
            {"#", col_index}, map -> Map.put(map, {col_index, row_index}, true)
          end)
        end)
      new(map, length(rows))
    end

    def transition(image, transitions) do
      block_size = if rem(image.size, 2) == 0, do: 2, else: 3
      block_image = divide(image, block_size)

      map =
        block_image.map
        |> Enum.reduce(%{}, fn {point, block}, map ->
          Map.put(map, point, transition_block(block, transitions))
        end)

      new(map, block_image.size)
      |> expand(block_size + 1)
    end

    def count_on(image) do
      image.map
      |> Map.values
      |> Enum.count(&(&1))
    end

    defp transition_block(image, transitions, rotate \\ 0, flip \\ 0) do
      transitions
      |> Map.fetch(image)
      |> case do
        :error ->
          {image, rotate, flip} = rotate_flip(image, rotate, flip)
          transition_block(image, transitions, rotate, flip)
        {:ok, transition} ->
          transition
      end
    end

    defp rotate_flip(image, rotate, flip) when rotate < 3 do
      {rotate(image), rotate + 1, flip}
    end
    defp rotate_flip(image, 3, 0) do
      {flip(image), 0, 1}
    end

    defp rotate(image) do
      map =
        image.map
        |> Map.keys
        |> Enum.reduce(%{}, fn {col, row}, map ->
          Map.put(map, {col, row}, Map.fetch!(image.map, {image.size - row - 1, col}))
        end)
      new(map, image.size)
    end

    defp flip(image) do
      map =
        image.map
        |> Map.keys
        |> Enum.reduce(%{}, fn {col, row}, map ->
          Map.put(map, {col, row}, Map.fetch!(image.map, {col, image.size - row - 1}))
        end)
      new(map, image.size)
    end

    defp divide(image, block_size) do
      map =
        for col <- 0..(div(image.size, block_size) - 1),
          row <- 0..(div(image.size, block_size) - 1)
        do
          {col, row}
        end
        |> Enum.reduce(%{}, fn {col, row}, map ->
          Map.put(map, {col, row}, build_block(image, block_size, col, row))
        end)
      new(map, div(image.size, block_size))
    end

    defp build_block(image, block_size, col, row) do
      map =
        for block_col <- 0..(block_size - 1),
          block_row <- 0..(block_size - 1)
        do
          {block_col, block_row}
        end
        |> Enum.reduce(%{}, fn {block_col, block_row}, map ->
          value = Map.fetch!(image.map, {col * block_size + block_col, row * block_size + block_row})
          Map.put(map, {block_col, block_row}, value)
        end)
      new(map, block_size)
    end

    defp expand(image, block_size) do
      map =
        for col <- 0..(image.size * block_size - 1),
          row <- 0..(image.size * block_size - 1)
        do
          {col, row}
        end
        |> Enum.reduce(%{}, fn {col, row}, map ->
          cell =
            image.map
            |> Map.fetch!({div(col, block_size), div(row, block_size)})
            |> Map.fetch!(:map)
            |> Map.fetch!({rem(col, block_size), rem(row, block_size)})
          Map.put(map, {col, row}, cell)
        end)
      new(map, image.size * block_size)
    end
  end

  def iterate(input \\ @default_input, iterations \\ @default_iterations) do
    transitions = parse_transitions(input)

    init_image()
    |> iterate(transitions, iterations)
    |> Image.count_on
  end

  def iterate_18 do
    iterate(@default_input, 18)
  end

  defp iterate(image, _transitions, 0), do: image
  defp iterate(image, transitions, iterations) do
    iterate(
      Image.transition(image, transitions),
      transitions,
      iterations - 1
    )
  end

  defp parse_transitions(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" => ")
      |> Enum.map(&Image.parse/1)
      |> List.to_tuple
    end)
    |> Enum.into(%{})
  end

  defp init_image do
    Image.parse(".#./..#/###")
  end
end
