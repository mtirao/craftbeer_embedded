defmodule CraftbeerFirmware.Gpio do

  use GenServer


  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
   # IO.puts(state)
  end

  @impl true
  def init(stack) do

    {:ok, :initted}
  end

  #@impl true
  #def handle_call(:pop, _from, state) do
  #  {:reply, head, tail}
  #end

  @impl true
  def handle_cast({:gpio, params}, ref) do

    %{"gpio": channel, "value": value} = params

    {:ok, gpio} = Circuits.GPIO.open(channel, :output)

    Circuits.GPIO.write(gpio, value)

    Circuits.GPIO.close(gpio)

    {:noreply, ref}
  end
end
