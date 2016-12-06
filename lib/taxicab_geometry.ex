defmodule TaxicabGeometry do
  def distance({x1, y1}, {x2, y2}) do
    abs(x2 - x1) + abs(y2 - y1)
  end

  def distance(%Telemetry{} = telemetry), do: distance(telemetry.location)

  def distance(loc) when is_tuple(loc) do
    distance({0, 0}, loc)
  end
end
