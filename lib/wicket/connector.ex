defmodule Wicket.Connector do

  use GenServer
  require Logger
  alias Wicket.Database.TransactionsService
  alias Wicket.Push

  def start_link(name) when is_atom(name),
    do: GenServer.start_link(__MODULE__, name, name: name)

  def init(name) do
    Logger.info "Connector #{name} is starting"
    Process.send_after(self, :loop, 1000)
    {:ok, configure(name)}
  end

  def handle_info(:loop, state) do
    Process.send_after(self, :loop, state.interval)

    state
    |> listtransactions
    |> TransactionsService.save_transactions(state.name)
    |> IO.inspect
    |> Push.transactions(state.name)
    |> IO.inspect

    {:noreply, state}
  end

  defp configure(name) do
    env = Application.get_env(:wicket, name)
    host     = Keyword.get(env, :host, "localhost")
    port     = Keyword.get(env, :port, 8332)
    user     = Keyword.get(env, :user, "bitcoinrpc")
    password = Keyword.get(env, :password, "")
    account  = Keyword.get(env, :account, "api")
    interval = Keyword.get(env, :interval, 5000)
    fetched  = Keyword.get(env, :fetched_transactions, 100)
    url      = Keyword.get(env, :webhook_url, "")
    config = %Gold.Config{hostname: host, port: port, user: user, password: password}

    {:ok, pid} = Gold.start_link(config)

    %{name: name, host: host, port: port, user: user, password: password, account: account,
      interval: interval, fetched_transactions: fetched, webhook_url: url, gold: pid}
  end

  defp listtransactions(state) do
    case Gold.listtransactions(state.gold, state.account, state.fetched_transactions) do
      {:ok, transactions} -> transactions
      {:error, error} ->
        Logger.error("Connection error: #{error}")
        []
    end
  end

end
