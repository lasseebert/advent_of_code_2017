defmodule Advent.Dec04Test do
  use ExUnit.Case

  alias Advent.Dec04

  describe "part 1" do
    test "valid passphrase" do
      assert Dec04.valid_passphrase?("aa bb cc dd ee") == true
    end

    test "invalid passphrase" do
      assert Dec04.valid_passphrase?("aa bb cc dd aa") == false
    end

    test "valid passphrase with almost same words" do
      assert Dec04.valid_passphrase?("aa bb cc dd aaa") == true
    end

    test "counting valid passphrases" do
      passphrases = """
      aa bb cc dd ee
      aa bb cc dd aa
      aa bb cc dd aaa
      """
      assert Dec04.count_valid_passphrases(passphrases) == 2
    end
  end
end
