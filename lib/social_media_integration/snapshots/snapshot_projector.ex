defmodule SocialMediaIntegration.Snapshots.SnapshotProjector do
  use Commanded.Projections.Ecto,
    application: SocialMediaIntegration.Application,
    repo: SocialMediaIntegration.Repo,
    name: "snapshot_projection",
    consistency: :strong

  import Ecto.Changeset

  alias SocialMediaIntegration.{
    Repo,
    Snapshots.Snapshot,
    Events.SnapshotRequested,
    Events.SnapshotSucceeded
  }

  project(%SnapshotRequested{} = event, fn multi ->
    snapshot = %Snapshot{
      user_id: event.user_id,
      uuid: event.snapshot_id,
      status: "requested"
    }

    multi
    |> Ecto.Multi.insert(:insert_snapshot, snapshot)
  end)

  project(%SnapshotSucceeded{snapshot_id: snapshot_id}, fn multi ->
    with %Snapshot{} = snapshot <- Snapshot |> Repo.get_by(uuid: snapshot_id),
         changes <- snapshot |> change(%{status: "successful"}) do
      multi |> Ecto.Multi.update(:update_snapshot, changes)
    end
  end)
end
