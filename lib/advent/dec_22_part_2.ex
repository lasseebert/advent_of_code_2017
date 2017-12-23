defmodule Advent.Dec22Part2 do
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

  --- Part Two ---

  As you go to remove the virus from the infected nodes, it evolves to resist your attempt.

  Now, before it infects a clean node, it will weaken it to disable your defenses. If it encounters an infected node, it will instead flag the node to be cleaned in the future. So:

  Clean nodes become weakened.
  Weakened nodes become infected.
  Infected nodes become flagged.
  Flagged nodes become clean.
  Every node is always in exactly one of the above states.

  The virus carrier still functions in a similar way, but now uses the following logic during its bursts of action:

  Decide which way to turn based on the current node:
  If it is clean, it turns left.
  If it is weakened, it does not turn, and will continue moving in the same direction.
  If it is infected, it turns right.
  If it is flagged, it reverses direction, and will go back the way it came.
  Modify the state of the current node, as described above.
  The virus carrier moves forward one node in the direction it is facing.
  Start with the same map (still using . for clean and # for infected) and still with the virus carrier starting in the middle and facing up.

  Using the same initial state as the previous example, and drawing weakened as W and flagged as F, the middle of the infinite grid looks like this, with the virus carrier's position again marked with [ ]:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . # . . .
  . . . #[.]. . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  This is the same as before, since no initial nodes are weakened or flagged. The virus carrier is on a clean node, so it still turns left, instead weakens the node, and moves left:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . # . . .
  . . .[#]W . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  The virus carrier is on an infected node, so it still turns right, instead flags the node, and moves up:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . .[.]. # . . .
  . . . F W . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  This process repeats three more times, ending on the previously-flagged node and facing right:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . W W . # . . .
  . . W[F]W . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  Finding a flagged node, it reverses direction and cleans the node:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . W W . # . . .
  . .[W]. W . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  The weakened node becomes infected, and it continues in the same direction:

  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . W W . # . . .
  .[.]# . W . . . .
  . . . . . . . . .
  . . . . . . . . .
  . . . . . . . . .
  Of the first 100 bursts, 26 will result in infection. Unfortunately, another feature of this evolved virus is speed; of the first 10000000 bursts, 2511944 will result in infection.

  Given your actual map, after 10000000 bursts of activity, how many bursts cause a node to become infected? (Do not count nodes that begin infected.)
  """

  @default_input_path "inputs/dec_22"
  @external_resource @default_input_path
  @default_input @default_input_path |> File.read!

  @default_bursts 10_000_000

  def count_infections(input \\ @default_input, bursts \\ @default_bursts) do
    input
    |> parse
    |> count_infections(bursts, 0)
  end

  defp count_infections(_state, 0, count), do: count
  defp count_infections(grid, bursts, count) do
    count_infections(
      burst(grid),
      bursts - 1,
      if(cell_state(grid) == :weakened, do: count + 1, else: count)
    )
  end

  defp burst(grid) do
    state = cell_state(grid)

    grid
    |> turn(state)
    |> change_state(state)
    |> move
  end

  defp turn(grid, :weakened), do: grid
  defp turn(grid, :infected), do: turn(grid, 1)
  defp turn(grid, :flagged), do: turn(grid, 2)
  defp turn(grid, :clean), do: turn(grid, 3)
  defp turn({map, coord, dir}, right_turns) when is_integer(right_turns) do 
    {map, coord, rem(dir + right_turns, 4)}
  end

  defp change_state({map, coord, dir}, :clean), do: {Map.put(map, coord, :weakened), coord, dir}
  defp change_state({map, coord, dir}, :infected), do: {Map.put(map, coord, :flagged), coord, dir}
  defp change_state({map, coord, dir}, :flagged), do: {Map.delete(map, coord), coord, dir}
  defp change_state({map, coord, dir}, :weakened), do: {Map.put(map, coord, :infected), coord, dir}

  defp move({map, {x, y}, 0}), do: {map, {x, y - 1}, 0}
  defp move({map, {x, y}, 1}), do: {map, {x + 1, y}, 1}
  defp move({map, {x, y}, 2}), do: {map, {x, y + 1}, 2}
  defp move({map, {x, y}, 3}), do: {map, {x - 1, y}, 3}

  defp cell_state({map, coord, _dir}) do
    Map.get(map, coord, :clean)
  end

  defp parse(input) do
    map =
      input
      |> String.trim
      |> String.split("\n")
      |> Enum.with_index
      |> Enum.reduce(%{}, fn {row, row_index}, map ->
        row
        |> String.graphemes
        |> Enum.with_index
        |> Enum.reduce(map, fn
          {"#", col_index}, map -> Map.put(map, {col_index, row_index}, :infected)
          {".", _col_index}, map -> map
        end)
      end)
    size = input |> String.replace("\n", "") |> String.length |> :math.sqrt |> trunc
    mid = div(size, 2)

    {map, {mid, mid}, 0}
  end
end
