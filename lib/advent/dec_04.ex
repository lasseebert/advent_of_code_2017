defmodule Advent.Dec04 do
  @moduledoc """
  --- Day 4: High-Entropy Passphrases ---

  A new system policy has been put in place that requires all accounts to use a passphrase instead of simply a password. A passphrase consists of a series of words (lowercase letters) separated by spaces.

  To ensure security, a valid passphrase must contain no duplicate words.

  For example:

  aa bb cc dd ee is valid.
  aa bb cc dd aa is not valid - the word aa appears more than once.
  aa bb cc dd aaa is valid - aa and aaa count as different words.
  The system's full passphrase list is available as your puzzle input. How many passphrases are valid?
  """

  @default_input_path "inputs/dec_04"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  def count_valid_passphrases(input \\ @default_input) do
    input
    |> String.trim
    |> String.split(~r/\n/)
    |> Enum.count(&valid_passphrase?/1)
  end

  def valid_passphrase?(passphrase) do
    passphrase
    |> String.split(~r/\W+/)
    |> Enum.sort
    |> Stream.chunk_every(2, 1)
    |> Enum.find(&match?([a, a], &1))
    |> is_nil
  end
end
