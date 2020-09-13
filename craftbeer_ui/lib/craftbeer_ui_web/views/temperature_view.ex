defmodule CraftbeerApiWeb.TemperatureView do
  use CraftbeerUiWeb, :view

  def render("temperature.json", %{temperature: temp}) do
    %{value: temp}
  end
end
