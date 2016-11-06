defmodule Wicket.Deposit do
  use Wicket.Web, :model

  schema "deposits" do
    field :address, :string
    field :txid, :string
    field :amount, :decimal
    field :confirmations, :integer
    field :timereceived, :integer
    field :pushed, :boolean, default: false
    field :pushed_conf, :integer, default: -1
    field :connector, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:address, :txid, :amount, :confirmations, :timereceived, :pushed, :pushed_conf, :connector])
    |> validate_required([:address, :txid, :amount, :confirmations, :timereceived, :connector])
    |> unique_constraint(:address_txid_connector)
  end
end
