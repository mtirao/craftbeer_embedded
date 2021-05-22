defmodule CraftbeerApiWeb.GpioView do
  use CraftbeerUiWeb, :view

  def render("gpio.json", %{gpio: temp}) do
    %{value: temp}
  end
end
