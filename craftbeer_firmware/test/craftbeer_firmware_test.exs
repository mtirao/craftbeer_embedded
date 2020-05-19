defmodule CraftbeerFirmwareTest do
  use ExUnit.Case
  doctest CraftbeerFirmware

  test "greets the world" do
    assert CraftbeerFirmware.hello() == :world
  end
end
