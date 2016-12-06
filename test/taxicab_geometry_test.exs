defmodule TaxicabGeometryTest do
  use ExUnit.Case

  test "distance from {0,0} to {10,10} is 20" do
    assert TaxicabGeometry.distance({0,0}, {10,10}) == 20
  end

  test "distance from {-5,-5} to {5,5} is 20" do
    assert TaxicabGeometry.distance({-5,-5}, {5,5}) == 20
  end

  test "distance from {-5,5} to {3,10} is 13" do
    assert TaxicabGeometry.distance({-5,5}, {3,10}) == 13
  end
end
