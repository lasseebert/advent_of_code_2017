defmodule Advent.Dec25Test do
  use ExUnit.Case

  alias Advent.Dec25

  describe "checksum" do
    test "small example" do
      input = """
      Begin in state A.
      Perform a diagnostic checksum after 6 steps.

      In state A:
        If the current value is 0:
          - Write the value 1.
          - Move one slot to the right.
          - Continue with state B.
        If the current value is 1:
          - Write the value 0.
          - Move one slot to the left.
          - Continue with state B.

      In state B:
        If the current value is 0:
          - Write the value 1.
          - Move one slot to the left.
          - Continue with state A.
        If the current value is 1:
          - Write the value 1.
          - Move one slot to the right.
          - Continue with state A.
      """

      assert Dec25.checksum(input) == 3
    end
  end
end
