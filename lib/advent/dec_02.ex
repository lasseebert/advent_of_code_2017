defmodule Advent.Dec02 do
  @moduledoc """
  --- Day 2: Corruption Checksum ---

  As you walk through the door, a glowing humanoid shape yells in your direction. "You there! Your state appears to be idle. Come help us repair the corruption in this spreadsheet - if we take another millisecond, we'll have to display an hourglass cursor!"

  The spreadsheet consists of rows of apparently-random numbers. To make sure the recovery process is on the right track, they need you to calculate the spreadsheet's checksum. For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.

  For example, given the following spreadsheet:

  5 1 9 5
  7 5 3
  2 4 6 8
  The first row's largest and smallest values are 9 and 1, and their difference is 8.
  The second row's largest and smallest values are 7 and 3, and their difference is 4.
  The third row's difference is 6.
  In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18.

  What is the checksum for the spreadsheet in your puzzle input?
  """

  @default_input_path "inputs/dec_02"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read! |> String.trim

  def run(input \\ @default_input) do
    input
    |> parse
    |> Enum.map(&Enum.min_max/1)
    |> Enum.map(fn {min, max} -> max - min end)
    |> Enum.sum
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r/\W/)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
