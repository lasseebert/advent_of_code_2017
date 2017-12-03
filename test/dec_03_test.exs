defmodule Advent.Dec03Test do
  use ExUnit.Case

  alias Advent.Dec03

  describe "part 1" do
    test "already at access port" do
      assert Dec03.run(1) == 0
    end

    test "12" do
      assert Dec03.run(12) == 3
    end

    test "23" do
      assert Dec03.run(23) == 2
    end

    test "1024" do
      assert Dec03.run(1024) == 31
    end
  end

  describe "part 2" do
    test "1" do
      assert Dec03.run_2(1) == 2
    end

    test "2" do
      assert Dec03.run_2(2) == 4
    end

    test "7" do
      assert Dec03.run_2(7) == 10
    end

    test "500" do
      assert Dec03.run_2(500) == 747
    end
  end
end
