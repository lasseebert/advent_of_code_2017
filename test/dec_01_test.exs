defmodule Advent.Dec01Test do
  use ExUnit.Case

  alias Advent.Dec01

  test "1122" do
    assert Dec01.run("1122") == 3
  end

  test "1111" do
    assert Dec01.run("1111") == 4
  end

  test "1234" do
    assert Dec01.run("1234") == 0
  end

  test "91212129" do
    assert Dec01.run("91212129") == 9
  end
end
