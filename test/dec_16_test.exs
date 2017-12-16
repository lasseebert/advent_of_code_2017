defmodule Advent.Dec16Test do
  use ExUnit.Case

  alias Advent.Dec16

  describe "dance" do
    test "small example" do
      programs = "abcde"
      moves = "s1,x3/4,pe/b"
      assert Dec16.dance(programs, Dec16.parse_moves(moves)) == "baedc"
    end
  end
end
