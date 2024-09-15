defmodule Bank.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :amount, :integer
      add :sender_id, references(:accounts, on_delete: :nothing)
      add :receiver_id, references(:accounts, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:transfers, [:sender_id])
    create index(:transfers, [:receiver_id])
  end
end
