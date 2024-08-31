defmodule MyApp.CLI do
  def main(args) do
    args
    |> parse_args()
    |> response()
    |> IO.puts()
  end

  defp parse_args(args) do
    {[msg: msg, n: n], _, _} =
      args
      |> OptionParser.parse(switches: [msg: :string, n: :integer])

    {msg, n}
  end

  defp response({msg, n}) do
    String.duplicate(msg, n)
  end
end
