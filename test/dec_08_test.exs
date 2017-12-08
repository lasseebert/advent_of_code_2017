defmodule Advent.Dec08Test do
  use ExUnit.Case

  alias Advent.Dec08

  describe "largest_register" do
    test "small example" do
      input = """
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
      """

      assert Dec08.largest_register(input) == 1
    end
  end

  describe "largest_running_register" do
    test "small example" do
      input = """
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
      """

      assert Dec08.largest_running_register(input) == 10
    end
  end
end
