defmodule Keypad1 do
  @base 10
  use Keypad

  # 1 2 3
  # 4 5 6
  # 7 8 9

  # Can't move further
  def next_key("U", key) when key in ["1", "2", "3"], do: key
  def next_key("D", key) when key in ["7", "8", "9"], do: key
  def next_key("L", key) when key in ["1", "4", "7"], do: key
  def next_key("R", key) when key in ["3", "6", "9"], do: key

  # The remainder are an offset of either +/-3 or +/-1
  def next_key("U", key), do: add(key, -3)
  def next_key("D", key), do: add(key, 3)
  def next_key("L", key), do: add(key, -1)
  def next_key("R", key), do: add(key, 1)
end
