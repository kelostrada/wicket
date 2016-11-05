defmodule Wicket.Repo.Migrations.CreateWithdrawal do
  use Ecto.Migration

  def change do
    create table(:withdrawals) do
      add :external_id, :string, null: false
      add :address, :string, null: false
      add :tx, :string
      add :amount, :decimal, null: false
      add :fee, :decimal
      add :confirmations, :integer
      add :timereceived, :integer
      add :pushed, :boolean, default: false, null: false
      add :pushed_conf, :integer, default: -1
      add :connector, :string, null: false

      timestamps()
    end

  end
end
