defmodule Hello do
  def elixir_is_cool do
    "Elixir is cool!"
    |> String.trim_trailing("!")
    |> String.split()
    |> List.first()
    |> dbg(pretty: true)
  end
end
