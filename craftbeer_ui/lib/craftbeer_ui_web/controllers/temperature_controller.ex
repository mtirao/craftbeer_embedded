defmodule CraftbeerApiWeb.TemperatureController do
  use CraftbeerUiWeb, :controller

  @base_dir "/sys/bus/w1/devices/"

  require Logger

  def index(conn, _params) do

    sensor_data = File.read!("/sys/bus/w1/devices/28-0317717417ff/w1_slave")
    [_, temp] = Regex.run(~r/t=(\d+)/, sensor_data)

    render(conn, "temperature.json", %{temperature: temp})
  end


  defp read_temp_forever do
    File.ls!(@base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))
      |> Enum.each(&read_temp(&1, @base_dir))

  end

  defp read_temp(sensor, base_dir) do
    sensor_data = File.read!("#{base_dir}#{sensor}/w1_slave")
    Logger.debug("reading sensor: #{sensor}: #{sensor_data}")
    {temp, _} = Regex.run(~r/t=(\d+)/, sensor_data)
    |> List.last
    |> Float.parse
    Logger.debug "#{temp/1000} C"
  end

end
