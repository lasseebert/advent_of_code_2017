defmodule Advent.Dec08 do
  @moduledoc """
  --- Day 8: I Heard You Like Registers ---

  You receive a signal directly from the CPU. Because of your recent assistance with jump instructions, it would like you to compute the result of a series of unusual register instructions.

  Each instruction consists of several parts: the register to modify, whether to increase or decrease that register's value, the amount by which to increase or decrease it, and a condition. If the condition fails, skip the instruction without modifying the register. The registers all start at 0. The instructions look like this:

  b inc 5 if a > 1
  a inc 1 if b < 5
  c dec -10 if a >= 1
  c inc -20 if c == 10
  These instructions would be processed as follows:

  Because a starts at 0, it is not greater than 1, and so b is not modified.
  a is increased by 1 (to 1) because b is less than 5 (it is 0).
  c is decreased by -10 (to 10) because a is now greater than or equal to 1 (it is 1).
  c is increased by -20 (to -10) because c is equal to 10.
  After this process, the largest value in any register is 1.

  You might also encounter <= (less than or equal to) or != (not equal to). However, the CPU doesn't have the bandwidth to tell you what all the registers are named, and leaves that to you to determine.

  What is the largest value in any register after completing the instructions in your puzzle input?

  --- Part Two ---

  To be safe, the CPU also needs to know the highest value held in any register during this process so that it can decide how much memory to allocate to these operations. For example, in the above instructions, the highest value ever held was 10 (in register c after the third instruction was evaluated).
  """

  @default_input_path "inputs/dec_08"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  def largest_register(input \\ @default_input) do
    input
    |> parse
    |> compute(%{})
    |> Map.values
    |> Enum.max
  end

  def largest_running_register(input \\ @default_input) do
    input
    |> parse
    |> Enum.reduce({%{}, 0}, fn instruction, {registers, max} ->
      registers = compute_one(instruction, registers)
      max = [max, registers |> Map.values |> Enum.max(fn -> 0 end)] |> Enum.max
      {registers, max}
    end)
    |> elem(1)
  end

  defp compute([], registers), do: registers
  defp compute([instruction | instructions], registers) do
    registers = compute_one(instruction, registers)
    compute(instructions, registers)
  end

  defp compute_one({v, o, a, iv, io, ia}, registers) do
    if condition(Map.get(registers, iv, 0), io, ia) do
      new_value = calc(Map.get(registers, v, 0), o, a)
      Map.put(registers, v, new_value)
    else
      registers
    end
  end

  defp condition(val_1, "==", val_2), do: val_1 == val_2
  defp condition(val_1, ">", val_2), do: val_1 > val_2
  defp condition(val_1, "<", val_2), do: val_1 < val_2
  defp condition(val_1, ">=", val_2), do: val_1 >= val_2
  defp condition(val_1, "<=", val_2), do: val_1 <= val_2
  defp condition(val_1, "!=", val_2), do: val_1 != val_2

  defp calc(val_1, "inc", val_2), do: val_1 + val_2
  defp calc(val_1, "dec", val_2), do: val_1 - val_2

  defp parse(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    captures =
      ~r/^(?<var>\w+) (?<op>inc|dec) (?<amount>-?\d+) if (?<if_var>\w+) (?<if_op>\S+) (?<if_amount>-?\d+)$/
        |> Regex.named_captures(line)
    {
      captures |> Map.fetch!("var"),
      captures |> Map.fetch!("op"),
      captures |> Map.fetch!("amount") |> String.to_integer,
      captures |> Map.fetch!("if_var"),
      captures |> Map.fetch!("if_op"),
      captures |> Map.fetch!("if_amount") |> String.to_integer
    }
  end
end
