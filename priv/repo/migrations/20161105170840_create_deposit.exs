defmodule Wicket.Repo.Migrations.CreateDeposit do
  use Ecto.Migration

  def change do
    create table(:deposits) do
      add :address, :string
      add :tx, :string
      add :amount, :decimal
      add :confirmations, :integer
      add :timereceived, :integer
      add :pushed, :boolean, default: false, null: false
      add :pushed_conf, :integer

      timestamps()
    end

  end
end
