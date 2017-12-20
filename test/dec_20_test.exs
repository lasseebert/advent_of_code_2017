defmodule Advent.Dec20Test do
  use ExUnit.Case

  alias Advent.Dec20

  describe "closest_long_run" do
    test "small example" do
      input = """
      p=<3,0,0>, v=<2,0,0>, a=<-1,0,0>
      p=<4,0,0>, v=<0,0,0>, a=<-2,0,0>
      """

      assert Dec20.closest_long_run(input) == 0
    end
  end
end
