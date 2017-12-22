defmodule Advent.Dec22Test do
  use ExUnit.Case

  alias Advent.Dec22

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
end
