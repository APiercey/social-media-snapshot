defmodule SocialMediaIntegration.Router do
  use Commanded.Commands.Router

  alias SocialMediaIntegration.Commands.RequestSnapshot
  alias SocialMediaIntegration.Aggregates.Snapshot

  alias SocialMediaIntegration.{
    Commands.RequestSnapshot,
    Commands.SucceedSnapshot,
    Aggregates.Snapshot
  }

  identify(Snapshot, by: :snapshot_uuid)
  dispatch(RequestSnapshot, to: Snapshot)
  dispatch(SucceedSnapshot, to: Snapshot)
end
