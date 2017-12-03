defmodule Advent.Dec03Test do
  use ExUnit.Case

  alias Advent.Dec03

  test "already at access port" do
    assert Dec03.run(1) == 0
  end

  test "12" do
    assert Dec03.run(12) == 3
  end

  test "23" do
    assert Dec03.run(23) == 2
  end

  test "1024" do
    assert Dec03.run(1024) == 31
  end
end
