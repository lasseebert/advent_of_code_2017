defmodule Advent.Dec24 do
  @moduledoc """
  --- Day 24: Electromagnetic Moat ---

  The CPU itself is a large, black building surrounded by a bottomless pit. Enormous metal tubes extend outward from the side of the building at regular intervals and descend down into the void. There's no way to cross, but you need to get inside.

  No way, of course, other than building a bridge out of the magnetic components strewn about nearby.

  Each component has two ports, one on each end. The ports come in all different types, and only matching types can be connected. You take an inventory of the components by their port types (your puzzle input). Each port is identified by the number of pins it uses; more pins mean a stronger connection for your bridge. A 3/7 component, for example, has a type-3 port on one side, and a type-7 port on the other.

  Your side of the pit is metallic; a perfect surface to connect a magnetic, zero-pin port. Because of this, the first port you use must be of type 0. It doesn't matter what type of port you end with; your goal is just to make the bridge as strong as possible.

  The strength of a bridge is the sum of the port types in each component. For example, if your bridge is made of components 0/3, 3/7, and 7/4, your bridge has a strength of 0+3 + 3+7 + 7+4 = 24.

  For example, suppose you had the following components:

  0/2
  2/2
  2/3
  3/4
  3/5
  0/1
  10/1
  9/10
  With them, you could make the following valid bridges:

  0/1
  0/1--10/1
  0/1--10/1--9/10
  0/2
  0/2--2/3
  0/2--2/3--3/4
  0/2--2/3--3/5
  0/2--2/2
  0/2--2/2--2/3
  0/2--2/2--2/3--3/4
  0/2--2/2--2/3--3/5
  (Note how, as shown by 10/1, order of ports within a component doesn't matter. However, you may only use each port on a component once.)

  Of these bridges, the strongest one is 0/1--10/1--9/10; it has a strength of 0+1 + 1+10 + 10+9 = 31.

  What is the strength of the strongest bridge you can make with the components you have available?
  """

  @default_input_path "inputs/dec_24"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  def strongest_bridge(input \\ @default_input) do
    input
    |> parse
    |> strongest_bridge(0, 0)
  end

  defp strongest_bridge(components, next_port, max_strength) do
    for {a, b} <- components, a == next_port or b == next_port do
      next_port = if a == next_port, do: b, else: a
      strongest_bridge(components -- [{a, b}], next_port, max_strength + a + b)
    end
    |> Enum.max(fn -> max_strength end)
  end

  defp parse(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split("/")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple
    end)
  end
end
