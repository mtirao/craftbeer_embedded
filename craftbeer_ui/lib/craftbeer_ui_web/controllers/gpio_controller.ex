defmodule CraftbeerApiWeb.GpioController do
  use CraftbeerUiWeb, :controller

  require Logger

  def index(conn, _params) do
    render(conn, "gpio.json", %{gpio: "ok"})
  end

  def create(conn, %{"channel" => gpio_params}) do

    %{channel: channel} = gpio_params

    {:ok, gpio} = Circuits.GPIO.open(channel, :output)
    Circuits.GPIO.write(gpio, 1)

    Circuits.GPIO.close(gpio)

    render(conn, "gpio.json", %{gpio: "ok"})
  end
end
