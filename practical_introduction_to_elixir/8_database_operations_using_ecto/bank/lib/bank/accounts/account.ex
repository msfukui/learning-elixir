defmodule Bank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bank.Transfers.Transfer

  schema "accounts" do
    field :name, :string
    field :number, :string
    field :balance, :integer
    has_many :send_transactions, Transfer, foreign_key: :sender_id
    has_many :recieve_transactions, Transfer, foreign_key: :receiver_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:number, :name, :balance])
    |> validate_required([:number, :name, :balance])
    |> unique_constraint(:number)
  end
end
