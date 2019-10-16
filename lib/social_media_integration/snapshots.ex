defmodule SocialMediaIntegration.Snapshots do
  alias SocialMediaIntegration.{
    Commands.RequestSnapshot,
    Commands.SucceedSnapshot,
    Commands.RejectSnapshot,
    Snapshots,
    Snapshots.Snapshot,
    Repo
  }

  alias Ecto.UUID

  def request_user_snapshot(user_id, token) do
    uuid = UUID.generate()

    %RequestSnapshot{user_id: user_id, token: token, snapshot_uuid: uuid}
    |> SocialMediaIntegration.Application.dispatch(consistency: :strong)
    |> case do
      :ok -> Snapshots.get_snapshot(uuid)
      error -> {:error, error}
    end
  end

  def succeed_snapshot(uuid, snapshot_payload) do
    %SucceedSnapshot{snapshot_uuid: uuid, payload: snapshot_payload}
    |> SocialMediaIntegration.Application.dispatch()
  end

  def reject_snapshot(uuid, reason) do
    %RejectSnapshot{snapshot_uuid: uuid, reason: reason}
    |> SocialMediaIntegration.Application.dispatch()
  end

  def get_snapshot(uuid) do
    Snapshot |> Repo.get_by(uuid: uuid)
  end

  def get_snapshots() do
    Snapshot |> Repo.all()
  end
end
