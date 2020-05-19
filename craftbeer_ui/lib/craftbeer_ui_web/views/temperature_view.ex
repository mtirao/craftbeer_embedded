defmodule CraftbeerApiWeb.TemperatureView do
  use CraftbeerUiWeb, :view

  alias CraftbeerApiWeb.TemperatureView

  def render("temperature.json", %{temperature: temp}) do
    %{value: temp}
  end
end
