defmodule Advent.Dec07Test do
  use ExUnit.Case

  alias Advent.Dec07

  describe "bottom_program" do
    test "small example" do
      input = """
      pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)
      """

      assert Dec07.bottom_program(input) == "tknk"
    end
  end

  describe "correct_weight" do
    test "small example" do
      input = """
      pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)
      """

      assert Dec07.correct_weight(input) == {"ugml", 60}
    end
  end
end
