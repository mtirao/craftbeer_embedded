defmodule CraftbeerApiWeb.SensorController do
  use CraftbeerUiWeb, :controller

  @base_dir "/sys/bus/w1/devices/"

  require Logger

  def index(conn, _params) do

    sensors_avail = scan_sensors()

    render(conn, "temperature.json", %{sensors: sensors_avail})
  end


  def scan_sensors do
    File.ls!(@base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))

  end

end
