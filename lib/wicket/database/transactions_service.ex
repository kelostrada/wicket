defmodule Wicket.Database.TransactionsService do
  alias Wicket.{Repo, Deposit, Withdrawal}
  import Ecto.Query
  require Logger

  def save_transactions(transactions, connector) do
    transactions
    |> Enum.map(&save_transaction(&1, connector))
    |> Enum.reject(& &1 == nil)
  end

  def save_transaction(%{category: :receive} = deposit, connector) do
    changes =
      deposit
      |> Map.from_struct
      |> Map.put(:connector, to_string(connector))

    result =
      case Repo.get_by(Deposit, txid: deposit.txid, address: deposit.address, connector: to_string(connector)) do
        nil -> %Deposit{}
        deposit -> deposit
      end
      |> Deposit.changeset(changes)
      |> Repo.insert_or_update

    case result do
      {:ok, model} -> model
      {:error, changeset} ->
        Logger.error("Error saving transaction #{inspect changeset}")
        nil
    end
  end
  def save_transaction(%{category: :send} = _withdrawal, _connector) do
    nil
  end
  def save_transaction(_transaction, _connector), do: nil


end
