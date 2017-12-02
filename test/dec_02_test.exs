defmodule Advent.Dec02Test do
  use ExUnit.Case

  alias Advent.Dec02

  describe "run" do
    test "small example" do
      input = "5\t1\t9\t5\n7\t5\t3\n2\t4\t6\t8\n"
      assert Dec02.run(input) == 18
    end
  end
end
