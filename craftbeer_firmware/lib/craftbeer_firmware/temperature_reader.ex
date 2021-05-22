defmodule CraftbeerFirmware.TemperatureReader do

    use GenServer
    require Logger

    def start_link(state) do
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    # IO.puts(state)
    end

    @impl true
    def init(stack) do
        
        {:ok, stack}
    end

    @impl true
    def handle_call({:temperature, sensor}, _from, state) do

        sensor_data = File.read!("/sys/bus/w1/devices/#{sensor}/w1_slave")
        Logger.debug("reading sensor: #{sensor}: #{sensor_data}")
        [_, temp] = Regex.run(~r/t=(\d+)/, sensor_data)

        {temp_value, _} = Float.parse(temp)

        celsius = temp_value / 1000

        GenServer.cast(CraftbeerFirmware.Board, {:show, 'Temp:#{celsius}' })


        {:reply, celsius, state}
    end

    #@impl true
    #def handle_cast({:show, text}, ref) do



    #  {:noreply, ref}
    #end

end