defmodule Advent.Dec11Test do
  use ExUnit.Case

  alias Advent.Dec11

  describe "num_steps" do
    test "example 1" do
      assert Dec11.num_steps("ne,ne,ne") == 3
    end

    test "example 2" do
      assert Dec11.num_steps("ne,ne,sw,sw") == 0
    end

    test "example 3" do
      assert Dec11.num_steps("ne,ne,s,s") == 2
    end

    test "example 4" do
      assert Dec11.num_steps("se,sw,se,sw,sw") == 3
    end
  end
end
