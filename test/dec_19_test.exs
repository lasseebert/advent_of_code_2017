defmodule Advent.Dec19Test do
  use ExUnit.Case

  alias Advent.Dec19

  describe "find_letters" do
    test "small example" do
      input = """
          |
          |  +--+
          A  |  C
      F---|----E|--+
          |  |  |  D
          +B-+  +--+
      """
      assert Dec19.find_letters(input) == "ABCDEF"
    end
  end

  describe "count_steps" do
    test "small example" do
      input = """
          |
          |  +--+
          A  |  C
      F---|----E|--+
          |  |  |  D
          +B-+  +--+
      """
      assert Dec19.count_steps(input) == 38
    end
  end
end
