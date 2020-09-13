defmodule CraftbeerFirmware.Board do

  use GenServer

  alias CraftbeerUi.Display

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
   # IO.puts(state)
  end

  @impl true
  def init(stack) do
    {:ok, ref} = Display.init()

    :timer.sleep(300)

    Display.clear(ref)

    :timer.sleep(300)

    Display.writeLine(ref, 1, 'WELCOME')
    Display.writeLine(ref, 2, 'CRAFTBEER v1.0.2')

    {:ok, ref}
  end

  #@impl true
  #def handle_call(:pop, _from, state) do
  #  {:reply, head, tail}
  #end

  @impl true
  def handle_cast({:show, text}, ref) do

    Display.writeLine(ref, 1, text)

    {:noreply, ref}
  end

end