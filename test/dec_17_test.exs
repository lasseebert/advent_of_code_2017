defmodule Advent.Dec17Test do
  use ExUnit.Case

  alias Advent.Dec17

  describe "value_after_last" do
    test "example" do
      assert Dec17.value_after_last(3) == 638
    end
  end
end
