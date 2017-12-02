defmodule Advent.Dec02Test do
  use ExUnit.Case

  alias Advent.Dec02

  describe "run" do
    test "small example" do
      input = "5\t1\t9\t5\n7\t5\t3\n2\t4\t6\t8\n"
      assert Dec02.run(input) == 18
    end
  end

  describe "run_2" do
    test "small example" do
      input = "5\t9\t2\t8\n9\t4\t7\t3\n3\t8\t6\t5\n"
      assert Dec02.run_2(input) == 9
    end
  end
end
