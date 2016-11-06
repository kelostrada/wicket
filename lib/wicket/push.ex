defmodule Wicket.Push do
  alias Wicket.{Deposit, Withdrawal}
  require Logger

  def push_transactions(transactions, url) do
    transactions
    |> Enum.map(&push_transaction(&1, url))
    |> Enum.reject(& &1 == nil)
  end

  def push_transaction(%{confirmations: confirmations, pushed_conf: pushed_conf,
      pushed: false} = transaction, url) when confirmations > pushed_conf do
    message =
      transaction
      |> create_message
      |> Poison.encode!
      
    HTTPoison.post(url, message, ["Content-Type": "application/json"])
  end
  def push_transaction(transaction, _url) do
    Logger.debug "Ignored transaction #{inspect transaction}"
    nil
  end

  defp create_message(%Deposit{} = deposit) do
    %{
      txid: deposit.txid,
      address: deposit.address,
      amount: deposit.amount,
      confirmations: deposit.confirmations,
      timereceived: deposit.timereceived
    }
  end
  defp create_message(%Withdrawal{} = withdrawal) do
    %{
      external_id: withdrawal.external_id,
      txid: withdrawal.txid,
      address: withdrawal.address,
      amount: withdrawal.amount,
      confirmations: withdrawal.confirmations,
      timereceived: withdrawal.timereceived,
      fee: withdrawal.fee
    }
  end

end
