defmodule Wicket.Deposit do
  use Wicket.Web, :model

  schema "deposits" do
    field :address, :string
    field :tx, :string
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
    |> cast(params, [:address, :tx, :amount, :confirmations, :timereceived, :pushed, :pushed_conf, :connector])
    |> validate_required([:address, :tx, :amount, :confirmations, :timereceived, :connector])
  end
end
