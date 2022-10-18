defmodule CraftbeerApiWeb.GpioController do
  use CraftbeerUiWeb, :controller

  require Logger

  def index(conn, _params) do
    render(conn, "gpio.json", %{gpio: "ok"})
  end

  def create(conn, %{"channel" => gpio_params}) do


    celsius = GenServer.cast(CraftbeerFirmware.Gpio, {:gpio, gpio_params})

    render(conn, "gpio.json", %{gpio: :ok})
  end
end
