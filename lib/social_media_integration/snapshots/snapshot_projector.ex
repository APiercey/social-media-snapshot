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
      uuid: event.snapshot_id,
      status: "requested"
    }

    multi
    |> Ecto.Multi.insert(:insert_snapshot, snapshot)
  end)

  project(%SnapshotSucceeded{snapshot_id: snapshot_id, payload: payload}, fn multi ->
    changes =
      Snapshot
      |> Repo.get_by(uuid: snapshot_id)
      |> change(%{
        status: "successful",
        first_name: payload.first_name,
        last_name: payload.last_name
      })

    multi |> Ecto.Multi.update(:update_snapshot, changes)
  end)
end
