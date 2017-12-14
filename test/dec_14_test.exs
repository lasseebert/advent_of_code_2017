defmodule Advent.Dec14Test do
  use ExUnit.Case

  alias Advent.Dec14

  describe "count_used" do
    test "given example" do
      assert Dec14.count_used("flqrgnkx") == 8108
    end
  end

  describe "count_regions" do
    test "given example" do
      assert Dec14.count_regions("flqrgnkx") == 1242
    end
  end
end
