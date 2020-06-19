defmodule CraftbeerApiWeb.GpioView do
  use CraftbeerUiWeb, :view

  alias CraftbeerApiWeb.GpioView

  def render("gpio.json", %{gpio: temp}) do
    %{value: temp}
  end
end
