defmodule Advent.Dec10Test do
  use ExUnit.Case

  alias Advent.Dec10

  describe "part_1" do
    test "small example" do
      assert Dec10.part_1(5, "3,4,1,5") == 12
    end
  end

  describe "part_2" do
    test "example 1" do
      assert Dec10.part_2("") == "a2582a3a0e66e6e86e3812dcb672a272"
    end

    test "example 2" do
      assert Dec10.part_2("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
    end

    test "example 3" do
      assert Dec10.part_2("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
    end

    test "example 4" do
      assert Dec10.part_2("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"
    end
  end
end
