defmodule SocialMediaIntegration.Events.SnapshotRequested do
  @derive Jason.Encoder
  defstruct [:user_id, :token, :snapshot_id]
end
