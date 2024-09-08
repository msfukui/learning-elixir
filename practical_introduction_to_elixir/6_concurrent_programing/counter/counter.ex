defmodule Counter do
  use GenServer

  def start_link(state, opts) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  def init(state) do
    IO.puts "Counter.init(#{state})"
    {:ok, state}
  end

  def handle_call(:up, from, state) do
    state = state + 1
    {:reply, "Count up: #{inspect state} from: #{inspect from}", state}
  end

  def handle_call(:down, from, state) do
    state = state - 1
    {:reply, "Count down: #{inspect state} from: #{inspect from}", state}
  end

  def handle_cast(:up, state) do
    state = state + 1
    IO.puts "Count up(async): #{inspect state}"
    {:noreply, state}
  end

  def handle_cast(:down, state) do
    state = state - 1
    IO.puts "Count down(async): #{inspect state}"
    {:noreply, state}
  end
end
