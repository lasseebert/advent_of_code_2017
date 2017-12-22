defmodule Advent.Dec22 do
  @moduledoc """
  --- Day 22: Sporifica Virus ---

  Diagnostics indicate that the local grid computing cluster has been contaminated with the Sporifica Virus. The grid computing cluster is a seemingly-infinite two-dimensional grid of compute nodes. Each node is either clean or infected by the virus.

  To prevent overloading the nodes (which would render them useless to the virus) or detection by system administrators, exactly one virus carrier moves through the network, infecting or cleaning nodes as it moves. The virus carrier is always located on a single node in the network (the current node) and keeps track of the direction it is facing.

  To avoid detection, the virus carrier works in bursts; in each burst, it wakes up, does some work, and goes back to sleep. The following steps are all executed in order one time each burst:

  If the current node is infected, it turns to its right. Otherwise, it turns to its left. (Turning is done in-place; the current node does not change.)
  If the current node is clean, it becomes infected. Otherwise, it becomes cleaned. (This is done after the node is considered for the purposes of changing direction.)
  The virus carrier moves forward one node in the direction it is facing.
  Diagnostics have also provided a map of the node infection status (your puzzle input). Clean nodes are shown as .; infected nodes are shown as #. This map only shows the center of the grid; there are many more nodes beyond those shown, but none of them are currently infected.

  The virus carrier begins in the middle of the map facing up.

  For example, suppose you are given a map like this:

  ..#
  #..
  ...
  Then, the middle of the infinite grid looks like this, with the virus carrier's position marked with [ ]:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . # . . .
  . . . #[.]. . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  The virus carrier is on a clean node, so it turns left, infects the node, and moves left:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . # . . .
  . . .[#]# . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  The virus carrier is on an infected node, so it turns right, cleans the node, and moves up:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . .[.]. # . . .
  . . . . # . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  Four times in a row, the virus carrier finds a clean, infects it, turns left, and moves forward, ending in the same place and still facing up:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . #[#]. # . . .
  . . # # # . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  Now on the same node as before, it sees an infection, which causes it to turn right, clean the node, and move forward:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . # .[.]# . . .
  . . # # # . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  After the above actions, a total of 7 bursts of activity had taken place. Of them, 5 bursts of activity caused an infection.

  After a total of 70, the grid looks like this, with the virus carrier facing up:

  . . . . . # # . .
  . . . . # . . # .
  . . . # . . . . #
  . . # . #[.]. . #
  . . # . # . . # .
  . . . . . # # . .
  . . . . . . . . .
  . . . . . . . . .
  By this time, 41 bursts of activity caused an infection (though most of those nodes have since been cleaned).

  After a total of 10000 bursts of activity, 5587 bursts will have caused an infection.

  Given your actual map, after 10000 bursts of activity, how many bursts cause a node to become infected? (Do not count nodes that begin infected.)
  """

  @default_input_path "inputs/dec_22"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  @default_bursts 10_000

  def count_infections(input \\ @default_input, bursts \\ @default_bursts) do
    input
    |> parse
    |> count_infections(bursts, 0)
  end

  defp count_infections(_state, 0, count), do: count
  defp count_infections(state, bursts, count) do
    count_infections(
      burst(state),
      bursts - 1,
      if(clean?(state), do: count + 1, else: count)
    )
  end

  defp burst(state) do
    clean = clean?(state)

    state
    |> turn(clean)
    |> infect_or_heal(clean)
    |> move
  end

  defp turn({map, coord, :up}, true), do: {map, coord, :left}
  defp turn({map, coord, :left}, true), do: {map, coord, :down}
  defp turn({map, coord, :down}, true), do: {map, coord, :right}
  defp turn({map, coord, :right}, true), do: {map, coord, :up}
  defp turn({map, coord, :up}, false), do: {map, coord, :right}
  defp turn({map, coord, :left}, false), do: {map, coord, :up}
  defp turn({map, coord, :down}, false), do: {map, coord, :left}
  defp turn({map, coord, :right}, false), do: {map, coord, :down}

  defp infect_or_heal({map, coord, dir}, true), do: {MapSet.put(map, coord), coord, dir}
  defp infect_or_heal({map, coord, dir}, false), do: {MapSet.delete(map, coord), coord, dir}

  defp move({map, {x, y}, :up}), do: {map, {x, y - 1}, :up}
  defp move({map, {x, y}, :left}), do: {map, {x - 1, y}, :left}
  defp move({map, {x, y}, :down}), do: {map, {x, y + 1}, :down}
  defp move({map, {x, y}, :right}), do: {map, {x + 1, y}, :right}

  defp clean?({map, coord, _dir}) do
    !MapSet.member?(map, coord)
  end

  defp parse(input) do
    map =
      input
      |> String.trim
      |> String.split("\n")
      |> Enum.with_index
      |> Enum.reduce(MapSet.new, fn {row, row_index}, map ->
        row
        |> String.graphemes
        |> Enum.with_index
        |> Enum.reduce(map, fn
          {"#", col_index}, map -> MapSet.put(map, {col_index, row_index})
          {".", _col_index}, map -> map
        end)
      end)
    size = input |> String.replace("\n", "") |> String.length |> :math.sqrt |> trunc
    mid = div(size, 2)

    {map, {mid, mid}, :up}
  end
end
