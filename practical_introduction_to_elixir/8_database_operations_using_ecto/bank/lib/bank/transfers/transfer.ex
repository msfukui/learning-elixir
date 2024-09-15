defmodule Bank.Transfers.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bank.Accounts.Account

  schema "transfers" do
    field :amount, :integer
    belongs_to :sender, Account, foreign_key: :sender_id
    belongs_to :receiver, Account, foreign_key: :receiver_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:amount, :sender_id, :receiver_id])
    |> validate_required([:amount, :sender_id, :receiver_id])
    |> validate_number(:amount, greater_than_or_equal_to: 1)
  end
end
