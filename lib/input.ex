defmodule Input do
  def read(name) do
    File.read!(Path.expand("inputs/#{name}.txt"))
    |> String.strip
  end
end
