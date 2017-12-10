defmodule Advent.Dec10Test do
  use ExUnit.Case

  alias Advent.Dec10

  describe "part_1" do
    test "small example" do
      assert Dec10.part_1(5, "3,4,1,5") == 12
    end
  end
end
