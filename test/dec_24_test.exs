defmodule Advent.Dec24Test do
  use ExUnit.Case

  alias Advent.Dec24

  describe "strongest_bridge" do
    test "small example" do
      input = """
      0/2
      2/2
      2/3
      3/4
      3/5
      0/1
      10/1
      9/10
      """

      assert Dec24.strongest_bridge(input) == 31
    end
  end
end
