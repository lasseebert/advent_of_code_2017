defmodule Advent.Dec12Test do
  use ExUnit.Case

  alias Advent.Dec12

  describe "num_group_0" do
    test "small example" do
      input = """
      0 <-> 2
      1 <-> 1
      2 <-> 0, 3, 4
      3 <-> 2, 4
      4 <-> 2, 3, 6
      5 <-> 6
      6 <-> 4, 5
      """
      assert Dec12.num_group_0(input) == 6
    end
  end

  describe "num_groups" do
    test "small example" do
      input = """
      0 <-> 2
      1 <-> 1
      2 <-> 0, 3, 4
      3 <-> 2, 4
      4 <-> 2, 3, 6
      5 <-> 6
      6 <-> 4, 5
      """
      assert Dec12.num_groups(input) == 2
    end
  end
end
