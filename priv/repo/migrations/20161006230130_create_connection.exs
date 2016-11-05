defmodule Wicket.Repo.Migrations.CreateConnection do
  use Ecto.Migration

  def change do
    create table(:connections) do
      add :name, :string
      add :interval, :integer
      add :fetched_transactions, :integer
      add :webhook_url, :string
      add :hostname, :string
      add :port, :integer
      add :user, :string
      add :password, :string
      add :account, :string

      timestamps()
    end

  end
end
