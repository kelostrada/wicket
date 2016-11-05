defmodule Wicket.ConnectorSupervisor do
  use Supervisor
  require Logger

  def start_link, do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok) do
     Application.get_env(:wicket, :connectors)
     |> Enum.map(&prepare_connector/1)
     |> supervise(strategy: :one_for_one)
  end

  defp prepare_connector(name), do: worker(Wicket.Connector, [name])

end
