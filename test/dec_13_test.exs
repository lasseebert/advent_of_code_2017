defmodule Advent.Dec13Test do
  use ExUnit.Case

  alias Advent.Dec13

  describe "severity" do
    test "small example" do
      input = """
      0: 3
      1: 2
      4: 4
      6: 4
      """

      assert Dec13.severity(input) == 24
    end
  end
end
