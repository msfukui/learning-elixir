# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bank.Repo.insert!(%Bank.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Bank.Accounts.Account
alias Bank.Repo

[
  %{number: "001", name: "Alice", balance: 0},
  %{number: "002", name: "Bob", balance: 0},
  %{number: "003", name: "Carol", balance: 0},
] |> Enum.each(fn attrs ->
  %Account{} |> Account.changeset(attrs) |> Repo.insert!()
end)
