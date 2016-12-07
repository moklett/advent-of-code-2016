defmodule Keypad1 do
  use Keypad

  # 1 2 3
  # 4 5 6
  # 7 8 9
  def next_key("U", key) when key in ["1", "2", "3"], do: key
  def next_key("D", key) when key in ["7", "8", "9"], do: key
  def next_key("L", key) when key in ["1", "4", "7"], do: key
  def next_key("R", key) when key in ["3", "6", "9"], do: key

  def next_key("U", key), do: add(key, -3)
  def next_key("D", key), do: add(key, 3)
  def next_key("L", key), do: add(key, -1)
  def next_key("R", key), do: add(key, 1)

  def add(key, num) do
    Integer.to_string(to_integer(key) + num)
  end
end
