defmodule Keypad2 do
  @base 16
  use Keypad

  #     1
  #   2 3 4
  # 5 6 7 8 9
  #   A B C
  #     D
  #

  # Can't move further
  def next_key("U", key) when key in ["5", "2", "1", "4", "9"], do: key
  def next_key("D", key) when key in ["5", "A", "D", "C", "9"], do: key
  def next_key("L", key) when key in ["1", "2", "5", "A", "D"], do: key
  def next_key("R", key) when key in ["1", "4", "9", "C", "D"], do: key

  # Moving up/down changes by 2
  def next_key("U", key) when key in ["3", "D"], do: add(key, -2)
  def next_key("D", key) when key in ["1", "B"], do: add(key, 2)

  # Moving up/down changes by 4 for rest
  def next_key("U", key) when key in ["6", "7", "8", "A", "B", "C"], do: add(key, -4)
  def next_key("D", key) when key in ["2", "3", "4", "6", "7", "8"], do: add(key, 4)

  # Moving left/right changes by 1 for the rest
  def next_key("L", key), do: add(key, -1)
  def next_key("R", key), do: add(key, 1)
end
