defmodule SocialMediaIntegration do
  alias SocialMediaIntegration.{
    Snapshots,
    Snapshots.Snapshot
  }

  alias Ecto.UUID

  def request_user_snapshot(user_id, token) do
    Snapshots.request_user_snapshot(user_id, token)
    |> render_snapshot()
  end

  def fetch_user_snapshot(uuid) do
    Snapshots.get_snapshot(uuid)
    |> render_snapshot()
  end

  defp render_snapshot(%Snapshot{
    uuid: uuid, 
    status: status, 
    user_id: user_id
  }) do
    {:ok, %{id: uuid, status: status, user_id: user_id}}
  end

  defp render_snapshot(error), do: error
end
