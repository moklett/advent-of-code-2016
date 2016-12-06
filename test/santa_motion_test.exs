defmodule SantaMotionTest do
  use ExUnit.Case

  test "process a single instruction without a starting value gives new telemetry" do
    assert SantaMotion.process("R3") == %Telemetry{
      heading: "E",
      location: {3,0},
      path: [{0,0}, {1,0}, {2,0}, {3,0}]
    }
  end

  test "process a single instruction with a starting value gives new heading and location" do
    telemetry = %Telemetry{heading: "E", location: {3,0}, path: [{0,0}, {1,0}, {2,0}, {3,0}]}
    assert SantaMotion.process("L2", telemetry) == %Telemetry{
      heading: "N",
      location: {3,2},
      path: [{0,0}, {1,0}, {2,0}, {3,0}, {3,1}, {3,2}]
    }
  end

  test "process a crossing instruction causes an intersection to be recorded" do
    telemetry = %Telemetry{heading: "W", location: {0,1}, path: [{0,0}, {1,0}, {1,1}, {0,1}]}
    assert SantaMotion.process("L2", telemetry) == %Telemetry{
      heading: "S",
      location: {0,-1},
      path: [{0,0}, {1,0}, {1,1}, {0,1}, {0,0}, {0,-1}],
      intersection: {0, 0}
    }
  end
end
