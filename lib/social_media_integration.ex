defmodule SocialMediaIntegration do
  alias SocialMediaIntegration.{
    Snapshots,
    Snapshots.Snapshot
  }

  alias Ecto.UUID

  def request_user_snapshot(user_id, token) do
    case Snapshots.request_user_snapshot(user_id, token) do
      %Snapshot{} = snapshot -> {:ok, render_snapshot(snapshot)}
      error -> error
    end
  end

  def fetch_user_snapshot(uuid) do
    case Snapshots.get_snapshot(uuid) do
      %Snapshot{} = snapshot -> {:ok, render_snapshot(snapshot)}
      error -> error
    end
  end

  def fetch_user_snapshots() do
    case Snapshots.get_snapshots() do
      snapshots when is_list(snapshots) -> {:ok, render_snapshots(snapshots)}
      error -> error
    end
  end

  defp render_snapshot(%Snapshot{
         uuid: uuid,
         status: status,
         first_name: first_name,
         last_name: last_name
       }) do
    %{id: uuid, status: status, first_name: first_name, last_name: last_name}
  end

  defp render_snapshots([head | tail]), do: [render_snapshot(head) | render_snapshots(tail)]
  defp render_snapshots([]), do: []
end
