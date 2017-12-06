defmodule Advent.Dec06Test do
  use ExUnit.Case

  alias Advent.Dec06

  test "small example" do
    input = "0\t2\t7\t0\n"
    assert Dec06.count_redist(input) == 5
  end

  test "loop length" do
    input = "0\t2\t7\t0\n"
    assert Dec06.loop_length(input) == 4
  end
end
