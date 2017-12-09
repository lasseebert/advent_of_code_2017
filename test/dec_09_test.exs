defmodule Advent.Dec09Test do
  use ExUnit.Case

  alias Advent.Dec09

  describe "total_score" do
    test "minimum example" do
      assert Dec09.total_score("{}") == 1
    end

    test "nested" do
      assert Dec09.total_score("{{{}}}") == 6
    end

    test "nested siblings" do
      assert Dec09.total_score("{{},{}}") == 5
    end

    test "complex nesting" do
      assert Dec09.total_score("{{{},{},{{}}}}") == 16
    end

    test "with garbage" do
      assert Dec09.total_score("{<a>,<a>,<a>,<a>}") == 1
    end

    test "with inner garbage" do
      assert Dec09.total_score("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
    end

    test "with inner garbage with cancelled !" do
      assert Dec09.total_score("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
    end

    test "with inner garbage with cancelled <" do
      assert Dec09.total_score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
    end
  end
end
