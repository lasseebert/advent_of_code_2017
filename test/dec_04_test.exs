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

  describe "part 2" do
    test "valid passphrase" do
      assert Dec04.valid_strong_passphrase?("abcde fghij") == true
    end

    test "invalid passphrase" do
      assert Dec04.valid_strong_passphrase?("abcde xyz ecdab") == false
    end

    test "valid passphrase with almost same words" do
      assert Dec04.valid_strong_passphrase?("a ab abc abd abf abj") == true
    end

    test "valid passphrase with same letters repeated different number of times" do
      assert Dec04.valid_strong_passphrase?("iiii oiii ooii oooi oooo") == true
    end

    test "invalid passphrase with same word rearranged" do
      assert Dec04.valid_strong_passphrase?("oiii ioii iioi iiio") == false
    end

    test "counting strong passphrases" do
      passphrases = """
      abcde fghij
      abcde xyz ecdab
      a ab abc abd abf abj
      iiii oiii ooii oooi oooo
      oiii ioii iioi iiio
      """

      assert Dec04.count_valid_strong_passphrases(passphrases) == 3
    end
  end
end
