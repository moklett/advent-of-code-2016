defmodule Day03 do
  @doc """
  --- Day 3: Squares With Three Sides ---

  Now that you can think clearly, you move deeper into the labyrinth of hallways
  and office furniture that makes up this part of Easter Bunny HQ. This must be
  a graphic design department; the walls are covered in specifications for
  triangles.

  Or are they?

  The design document gives the side lengths of each triangle it describes,
  but... 5 10 25? Some of these aren't triangles. You can't help but mark the
  impossible ones.

  In a valid triangle, the sum of any two sides must be larger than the
  remaining side. For example, the "triangle" given above is impossible, because
  5 + 10 is not larger than 25.

  In your puzzle input, how many of the listed triangles are possible?

      iex> Day03.solve1
      983
  """
  def solve1 do
    Input.read("day03")
    |> String.split("\n")
    |> Enum.map(&sort_and_split/1)
    |> Enum.filter(&valid?/1)
    |> length
  end

  @doc """
  --- Part Two ---

  Now that you've helpfully marked up their design documents, it occurs to you
  that triangles are specified in groups of three vertically. Each set of three
  numbers in a column specifies a triangle. Rows are unrelated.

  For example, given the following specification, numbers with the same hundreds
  digit would be part of the same triangle:

      101 301 501
      102 302 502
      103 303 503
      201 401 601
      202 402 602
      203 403 603

  In your puzzle input, and instead reading by columns, how many of the listed
  triangles are possible?

      iex> Day03.solve2
      1836
  """
  def solve2 do
    Input.read("day03")
    |> String.split("\n")
    |> Enum.map(&split_line/1)
    |> Enum.chunk(3) # A list of 3 line lists
    |> Enum.reduce([], &rotate_and_append/2)
    |> Enum.map(&Enum.sort/1)
    |> Enum.filter(&valid?/1)
    |> length
  end

  defp sort_and_split(string) do
    string
    |> split_line
    |> Enum.sort
  end

  defp split_line(string) do
    string
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  defp valid?([a, b, c]) do
    (a + b) > c
  end

  # `lines` is a list of 3 lists:
  #
  #     [
  #       [20, 23, 26],
  #       [21, 24, 27],
  #       [22, 25, 28]
  #     ]
  #
  # `final` is a list of lists to which we will append:
  #
  #     [
  #       [10, 11, 12]
  #     ]
  #
  # The return value will be `lines` "rotated" and appended to `final`:
  #
  #     [
  #       [10, 11, 12],
  #       [20, 21, 22],
  #       [23, 24, 25],
  #       [26, 27, 28],
  #
  defp rotate_and_append(lines, final) do
    rotated = lines
      |> Enum.reduce([[], [], []], fn(row, [a, b, c]) ->
        [
          [Enum.at(row, 0) | a],
          [Enum.at(row, 1) | b],
          [Enum.at(row, 2) | c]
        ]
      end)

    Enum.concat(final, rotated)
  end
end
