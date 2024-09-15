defmodule Bank.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :number, :string
      add :name, :string
      add :balance, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:accounts, [:number])
  end
end
