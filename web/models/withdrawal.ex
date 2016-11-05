defmodule Wicket.Withdrawal do
  use Wicket.Web, :model

  schema "withdrawals" do
    field :external_id, :string
    field :address, :string
    field :tx, :string
    field :amount, :decimal
    field :fee, :decimal
    field :confirmations, :integer
    field :timereceived, :integer
    field :pushed, :boolean, default: false
    field :pushed_conf, :integer
    field :connector, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:external_id, :address, :tx, :amount, :fee, :confirmations, :timereceived, :pushed, :pushed_conf, :connector])
    |> validate_required([:external_id, :address, :tx, :connector])
  end
end
