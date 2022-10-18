defmodule CraftbeerFirmware.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CraftbeerFirmware.Supervisor]

    VintageNet.configure("wlan0", %{
      type: VintageNetWiFi,
      vintage_net_wifi: %{
        networks: [
          %{
            key_mgmt: :wpa_psk,
            psk: "2fV8tY1d",
            ssid: "DIRECTVNET_5G_63516B"
          }
        ]
      },
      ipv4: %{method: :dhcp}
    })

    children =
      [
        # Children for all targets
        # Starts a worker by calling: CraftbeerFirmware.Worker.start_link(arg)
        # {CraftbeerFirmware.Worker, arg},
       # %{
       #   id: CraftbeerFirmware.Board,
       #   start: {CraftbeerFirmware.Board, :start_link, [[:hello]]}
       # }
       %{
         id: CraftbeerFirmware.Board,
         start: {CraftbeerFirmware.Board, :start_link, [[:hello, :world]]}
       },
       %{
         id: CraftbeerFirmware.TemperatureReader,
         start: {CraftbeerFirmware.TemperatureReader, :start_link, [[:hello, :world]]}
       },
       %{
        id: CraftbeerFirmware.Gpio,
        start: {CraftbeerFirmware.Gpio, :start_link, [[:hello, :world]]}
      }
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: CraftbeerFirmware.Worker.start_link(arg)
      # {CraftbeerFirmware.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: CraftbeerFirmware.Worker.start_link(arg)
      # {CraftbeerFirmware.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:craftbeer_firmware, :target)
  end


end
