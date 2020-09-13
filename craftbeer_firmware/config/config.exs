# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

import_config "../../craftbeer_ui/config/config.exs"
import_config "../../craftbeer_ui/config/prod.exs"

config :craftbeer_firmware, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1589754594"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

config :craftbeer_ui, CraftbeerUiWeb.Endpoint,
  code_reloader: false,
  http: [port: 80],
  load_from_system_env: false,
  server: true,
  url: [host: "nerves.local", port: 80]

config :nerves_network,
  regulatory_domain: "US"

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"


config :vintage_net,
  config: [
    {"wlan0",
      %{
        type: VintageNetWiFi,
        vintage_net_wifi: %{
          networks: [
            %{
              key_mgmt: :wpa_psk,
              ssid: "Fibertel WiFi834 2.4GHz",
              psk: "0049252584"
            }
          ]
        },
        ipv4: %{method: :dhcp},
      }
    }
  ]

  
config :nerves, :firmware,
fwup_conf: "config/rpi/fwup.conf"

if Mix.target() != :host do
  import_config "target.exs"
end
