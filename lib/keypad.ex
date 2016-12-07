defmodule Keypad do
  @callback next_key(String.t, String.t) :: String.t

  defmacro __using__(_) do
    quote do
      @behaviour Keypad
      @start_key "5"

      import String, only: [codepoints: 1, split: 2, last: 1, to_integer: 1, to_integer: 2]
      import Enum, only: [reduce: 3]

      def follow_one(dir, start_key) do
        next_key(dir, start_key)
      end

      def follow_row(row, start_key) do
        row
        |> codepoints
        |> reduce(start_key, &follow_one/2)
      end

      def follow_rows(rows) do
        rows
          |> split("\n")
          |> reduce("", &append_next_key/2)
      end

      defp append_next_key(row, code) do
        last_number = last(code) || @start_key
        next_number = follow_row(row, last_number)
        code <> next_number
      end

      def add(key, num) do
        Integer.to_string(
          (to_integer(key, @base) + num),
          @base
        )
      end
    end
  end
end
