defmodule Advent.Dec05Test do
  use ExUnit.Case

  alias Advent.Dec05

  describe "count_jumps" do
    test "simple example" do
      input = """
      0
      3
      0
      1
      -3
      """

      assert Dec05.count_jumps(input) == 5
    end
  end

  describe "count_jumps_2" do
    test "simple example" do
      input = """
      0
      3
      0
      1
      -3
      """

      assert Dec05.count_jumps_2(input) == 10
    end
  end
end
