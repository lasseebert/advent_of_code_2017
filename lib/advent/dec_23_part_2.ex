defmodule Advent.Dec23Part2 do
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

  --- Part Two ---

  Now, it's time to fix the problem.

  The debug mode switch is wired directly to register a. You flip the switch, which makes register a now start at 1 when the program is executed.

  Immediately, the coprocessor begins to overheat. Whoever wrote this program obviously didn't choose a very efficient implementation. You'll need to optimize the program if it has any hope of completing before Santa needs that printer working.

  The coprocessor's ultimate goal is to determine the final value left in register h once the program completes. Technically, if it had that... it wouldn't even need to run the program.

  After setting register a to 1, if the program were to run to completion, what value would be left in register h?
  """

  def run_debug do
    # The program translates to this program, which just takes every 17th number between 108_100 and 125099 and count
    # the non-primes of those in the most naive way one can imagine.
    #
    #   debug = true
    #   n = 81
    #   max_n = n
    #   count = 0
    #
    #   if debug do
    #     n = 108_100
    #     max_n = n + 17_000
    #   end
    #
    #   loop do
    #     found = false
    #
    #     for a = 2; a < n; a++ do
    #       for b = 2; b < n, b++ do
    #         if a * b == n do
    #           found = true
    #         end
    #       end
    #     end
    #
    #     if found do
    #       count = count + 1
    #     end
    #
    #     if n == max_n do
    #       print count
    #       exit
    #     end
    #
    #     n = n + 17
    #   end

    count_non_primes(108_100, 125100, 17, 0)
  end

  defp count_non_primes(from, to, _step, count) when from > to, do: count
  defp count_non_primes(from, to, step, count) do
    count_non_primes(
      from + step,
      to,
      step,
      if(prime?(from), do: count, else: count + 1)
    )
  end

  defp prime?(n), do: prime?(n, 2, n |> :math.sqrt |> trunc)
  defp prime?(_n, i, max) when i > max, do: true
  defp prime?(n, i, max) do
    if n / i == div(n, i) do
      false
    else
      prime?(n, i + 1, max)
    end
  end
end
