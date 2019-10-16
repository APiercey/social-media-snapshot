defmodule SocialMediaIntegration.Aggregates.Snapshot do
  defstruct [:uuid, :user_id, :status]

  alias SocialMediaIntegration.Commands.{
    RequestSnapshot,
    SucceedSnapshot
  }

  alias SocialMediaIntegration.Events.{
    SnapshotRequested,
    SnapshotSucceeded
  }

  def execute(%__MODULE__{uuid: nil}, %RequestSnapshot{} = command) do
    %SnapshotRequested{
      snapshot_id: command.snapshot_uuid,
      user_id: command.user_id,
      token: command.token
    }
  end

  def execute(%__MODULE__{}, %SucceedSnapshot{} = command) do
    %SnapshotSucceeded{
      snapshot_id: command.snapshot_uuid,
      payload: command.payload
    }
  end

  def apply(%__MODULE__{} = snapshot, %SnapshotRequested{} = event) do
    %{snapshot | uuid: event.snapshot_id, user_id: event.user_id, status: "requested"}
  end

  def apply(%__MODULE__{} = snapshot, %SnapshotSucceeded{} = _event) do
    %{snapshot | status: "successful"}
  end
end
