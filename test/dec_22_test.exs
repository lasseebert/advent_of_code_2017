defmodule Advent.Dec22Test do
  use ExUnit.Case

  alias Advent.Dec22
  alias Advent.Dec22Part2

  describe "count_infections" do
    test "given example" do
      input = """
      ..#
      #..
      ...
      """

      assert Dec22.count_infections(input, 7) == 5
      assert Dec22.count_infections(input, 70) == 41
      assert Dec22.count_infections(input) == 5587
    end
  end

  describe "part 2" do
    test "given example" do
      input = """
      ..#
      #..
      ...
      """

      assert Dec22Part2.count_infections(input, 100) == 26
      assert Dec22Part2.count_infections(input) == 2_511_944
    end
  end
end
