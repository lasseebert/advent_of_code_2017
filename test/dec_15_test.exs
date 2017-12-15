defmodule Advent.Dec15Test do
  use ExUnit.Case

  alias Advent.Dec15

  describe "match_count" do
    test "small example" do
      assert Dec15.match_count(65, 8921, 5) == 1
    end

    # Comment out because it is slow
    #test "full example" do
    #  assert Dec15.match_count(65, 8921) == 588
    #end
  end

  describe "picky_match_count" do
    test "small example" do
      assert Dec15.picky_match_count(65, 8921, 5) == 0
    end

    # Comment out because it is slow
    #test "full example" do
    #  assert Dec15.picky_match_count(65, 8921) == 309
    #end
  end
end
