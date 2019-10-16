defmodule SocialMediaIntegration.Snapshots.SnapshotEventHandler do
  use Commanded.Event.Handler,
    application: SocialMediaIntegration.Application,
    name: "snapshots_event_handler"

  alias Commanded.Event.FailureContext

  alias SocialMediaIntegration.{
    Events.SnapshotRequested,
    Snapshots
  }

  def handle(%SnapshotRequested{snapshot_id: uuid, token: token}, _metadata) do
    call_facebook(uuid, token)
    |> maybe_succeed_snapshot(uuid)
  end

  def error(
        {:error, _error},
        %SnapshotRequested{},
        %FailureContext{context: context}
      ) do
    context
    |> record_failure()
    |> Map.get(:failures)
    |> case do
      failures when failures >= 3 ->
        :skip

      _ ->
        {:retry, context}
    end
  end

  defp call_facebook(user_id, token) do
    [token: token, user_id: user_id]
    |> FacebookGraphClient.new()
    |> FacebookGraphClient.fetch_user_information()
    |> case do
      {:ok, %{user_data: user_data}} -> {:ok, user_data}
      {:error, _error} = error -> error
    end
  end

  defp maybe_succeed_snapshot({:ok, user_data}, uuid) do
    Snapshots.succeed_snapshot(uuid, user_data)
  end

  defp maybe_succeed_snapshot({:error, _} = error, _uuid), do: error

  defp record_failure(context) do
    Map.update(context, :failures, 1, fn failures -> failures + 1 end)
  end
end
