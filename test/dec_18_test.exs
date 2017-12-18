defmodule Advent.Dec18Test do
  use ExUnit.Case

  alias Advent.Dec18

  describe "first_recover" do
    test "small example" do
      input = """
      set a 1
      add a 2
      mul a a
      mod a 5
      snd a
      set a 0
      rcv a
      jgz a -1
      set a 1
      jgz a -2
      """

      assert Dec18.first_recover(input) == 4
    end
  end
end
