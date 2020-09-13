defmodule CraftbeerApiWeb.SensorView do
  use CraftbeerUiWeb, :view

  def render("temperature.json", %{sensors: temp}) do
    %{values: temp}
  end
end
