defmodule Advent.Dec23 do
  @moduledoc """
  --- Day 23: Coprocessor Conflagration ---

  You decide to head directly to the CPU and fix the printer from there. As you get close, you find an experimental coprocessor doing so much work that the local programs are afraid it will halt and catch fire. This would cause serious issues for the rest of the computer, so you head in and see what you can do.

  The code it's running seems to be a variant of the kind you saw recently on that tablet. The general functionality seems very similar, but some of the instructions are different:

  set X Y sets register X to the value of Y.
  sub X Y decreases register X by the value of Y.
  mul X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
  jnz X Y jumps with an offset of the value of Y, but only if the value of X is not zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
  Only the instructions listed above are used. The eight registers here, named a through h, all start at 0.

  The coprocessor is currently set to some kind of debug mode, which allows for testing, but prevents it from doing any meaningful work.

  If you run the program (your puzzle input), how many times is the mul instruction invoked?
  """

  @default_input_path "inputs/dec_23"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  def count_mul(input \\ @default_input) do
    program = input |> parse

    state = %{
      program: program,
      current: 0,
      registers: %{}
    }

    count_mul(state, 0)
  end

  defp count_mul(%{program: program, current: current} = state, count) do
    if done?(state) do
      count
    else
      next_state = execute_one_line(state)
      count = if program |> Map.fetch!(current) |> elem(0) == :mul, do: count + 1, else: count
      count_mul(next_state, count)
    end
  end

  defp execute_one_line(state) do
    line = state.program |> Map.fetch!(state.current)
    execute_one_line(state, line)
  end

  defp execute_one_line(state, {:set, [reg, val]}) do
    val = eval(state.registers, val)
    %{
      state |
      registers: state.registers |> Map.put(reg, val),
      current: state.current + 1
    }
  end
  defp execute_one_line(state, {:sub, [reg, val]}) do
    val = eval(state.registers, val)
    %{
      state |
      registers: state.registers |> Map.update(reg, 0 - val, fn num -> num - val end),
      current: state.current + 1
    }
  end
  defp execute_one_line(state, {:mul, [reg, val]}) do
    val = eval(state.registers, val)
    %{
      state |
      registers: state.registers |> Map.update(reg, 0, fn num -> num * val end),
      current: state.current + 1
    }
  end
  defp execute_one_line(state, {:jnz, [reg, val]}) do
    reg = eval(state.registers, reg)
    val = eval(state.registers, val)
    %{
      state |
      current: if(reg == 0, do: state.current + 1, else: state.current + val)
    }
  end

  defp eval(_registers, value) when is_number(value), do: value
  defp eval(registers, name), do: Map.get(registers, name, 0)

  defp done?(%{program: program, current: current}) do
    Map.fetch(program, current) == :error
  end

  defp parse(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.with_index
    |> Enum.map(fn {line, index} -> {index, line} end)
    |> Enum.into(%{})
  end

  @instructions ~w[set sub mul jnz]
  for instruction <- @instructions do
    defp parse_line(unquote(instruction) <> " " <> rest) do
      {
        unquote(instruction) |> String.to_atom,
        rest |> String.split(" ") |> Enum.map(&parse_value/1)
      }
    end
  end

  defp parse_value(value) do
    if Regex.match?(~r/^-?\d+$/, value) do
      String.to_integer(value)
    else
      value
    end
  end
end
