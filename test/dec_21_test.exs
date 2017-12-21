defmodule Advent.Dec21Test do
  use ExUnit.Case

  alias Advent.Dec21

  describe "iterate" do
    test "small example" do
      input = """
      ../.# => ##./#../...
      .#./..#/### => #..#/..../..../#..#
      """

      assert Dec21.iterate(input, 2) == 12
    end
  end
end
