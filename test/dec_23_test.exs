defmodule Advent.Dec23Test do
  use ExUnit.Case

  alias Advent.Dec23
  alias Advent.Dec23Part2

  describe "count_mul" do
    test "running without error" do
      Dec23.count_mul
    end
  end

  describe "run_debug" do
    test "running without error" do
      Dec23Part2.run_debug
    end
  end
end
