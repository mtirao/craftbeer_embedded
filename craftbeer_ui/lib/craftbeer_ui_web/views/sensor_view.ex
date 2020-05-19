defmodule CraftbeerApiWeb.SensorView do
  use CraftbeerUiWeb, :view

  alias CraftbeerApiWeb.SensorView

  def render("temperature.json", %{sensors: temp}) do
    %{values: temp}
  end
end
