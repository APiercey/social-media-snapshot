defmodule SocialMediaIntegration.Snapshots.SnapshotEventHandler do
  use Commanded.Event.Handler,
    application: SocialMediaIntegration.Application,
    name: "snapshots_event_handler"

  alias SocialMediaIntegration.{
    Events.SnapshotRequested,
    Events.SnapshotSucceeded,
    Snapshots
  }

  def handle(%SnapshotRequested{snapshot_id: uuid}, _metadata) do
    uuid
    |> Snapshots.attempt_snapshot()
    |> case do
      :ok -> :ok
      _ -> {:error, :failed}
    end
  end
end
