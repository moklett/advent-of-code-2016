defmodule Keypad do
  def track(dir, start_key) when byte_size(dir) == 1 do
    next_key(dir, start_key)
  end

  def track(row, start_key) do
    row
    |> String.codepoints
    |> Enum.reduce(start_key, &track/2)
  end

  # 1 2 3
  # 4 5 6
  # 7 8 9
  defp next_key("U", key) when key in [1, 2, 3], do: key
  defp next_key("D", key) when key in [7, 8, 9], do: key
  defp next_key("L", key) when key in [1, 4, 7], do: key
  defp next_key("R", key) when key in [3, 6, 9], do: key

  defp next_key("U", key), do: key - 3
  defp next_key("D", key), do: key + 3
  defp next_key("L", key), do: key - 1
  defp next_key("R", key), do: key + 1
end
