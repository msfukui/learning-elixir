defmodule AwesomeModule do
  def greet(name) do
    "#{hello()} #{name}"
  end

  def msg(name \\ "Elixir") do
    "#{name} is beautiful."
  end

  defp hello do
    "Hello!"
  end
end
