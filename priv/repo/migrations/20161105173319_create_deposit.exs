defmodule Wicket.Repo.Migrations.CreateDeposit do
  use Ecto.Migration

  def change do
    create table(:deposits) do
      add :address, :string, null: false
      add :tx, :string, null: false
      add :amount, :decimal, null: false
      add :confirmations, :integer, default: 0, null: false
      add :timereceived, :integer, null: false
      add :pushed, :boolean, default: false, null: false
      add :pushed_conf, :integer, null: false, default: -1
      add :connector, :string, null: false

      timestamps()
    end

  end
end
