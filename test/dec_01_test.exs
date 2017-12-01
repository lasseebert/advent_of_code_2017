defmodule Advent.Dec01Test do
  use ExUnit.Case

  alias Advent.Dec01

  describe "run" do
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

  describe "run_part_2" do
    test "1212" do
      assert Dec01.run_part_2("1212") == 6
    end

    test "1221" do
      assert Dec01.run_part_2("1221") == 0
    end

    test "123425" do
      assert Dec01.run_part_2("123425") == 4
    end

    test "123123" do
      assert Dec01.run_part_2("123123") == 12
    end

    test "12131415" do
      assert Dec01.run_part_2("12131415") == 4
    end
  end
end
