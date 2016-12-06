defmodule SantaMotion do
  def process(instruction) do
    process(instruction, %Telemetry{})
  end

  def process(instruction, telemetry) do
    {turn, steps} = parse_instruction(instruction)

    telemetry
    |> update_heading(turn)
    |> move_forward(steps)
  end

  defp parse_instruction(instruction) do
    {turn, steps} = String.split_at(instruction, 1)
    {turn, String.to_integer(steps)}
  end

  defp update_heading(telemetry, turn) do
    %{telemetry | heading: next_heading(telemetry.heading, turn)}
  end

  defp move_forward(telemetry, 0), do: telemetry

  defp move_forward(%Telemetry{location: {x, y}} = telemetry, 1) do
    new_location = case telemetry.heading do
      "N" -> {x, y+1}
      "S" -> {x, y-1}
      "W" -> {x-1, y}
      "E" -> {x+1, y}
    end

    %{telemetry |
      location: new_location,
      path: Enum.concat(telemetry.path, [new_location]),
      intersection: intersection(telemetry, new_location)
    }
  end

  defp move_forward(telemetry, steps) do
    move_forward(telemetry, 1) |> move_forward(steps-1)
  end

  defp next_heading("N", "R"), do: "E"
  defp next_heading("N", "L"), do: "W"
  defp next_heading("S", "R"), do: "W"
  defp next_heading("S", "L"), do: "E"
  defp next_heading("E", "R"), do: "S"
  defp next_heading("E", "L"), do: "N"
  defp next_heading("W", "R"), do: "N"
  defp next_heading("W", "L"), do: "S"

  defp intersection(%Telemetry{intersection: nil, path: history}, loc) do
    case Enum.member?(history, loc) do
      true -> loc
      false -> nil
    end
  end

  defp intersection(telemetry, _loc), do: telemetry.intersection
end
