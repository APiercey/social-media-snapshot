defmodule SocialMediaIntegration.Snapshots do
  alias SocialMediaIntegration.{
    Commands.RequestSnapshot,
    Commands.SucceedSnapshot,
    Snapshots,
    Snapshots.Snapshot,
    Repo
  }

  alias Ecto.UUID

  def request_user_snapshot(user_id, token) do
    uuid = UUID.generate()

    %RequestSnapshot{user_id: user_id, token: token}
    |> RequestSnapshot.put_uuid(uuid)
    |> SocialMediaIntegration.Application.dispatch(consistency: :strong)
    |> case do
      :ok -> Snapshots.get_snapshot(uuid)
      error -> {:error, error}
    end
  end

  def attempt_snapshot(uuid) do
    fake_payload = %{first_name: "Hello", last_name: "World"}

    %SucceedSnapshot{snapshot_uuid: uuid, payload: fake_payload}
    |> SocialMediaIntegration.Application.dispatch()
  end

  def get_snapshot(uuid) do
    Snapshot |> Repo.get_by(uuid: uuid)
  end
end
