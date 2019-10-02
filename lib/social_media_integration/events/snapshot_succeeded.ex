defmodule SocialMediaIntegration.Events.SnapshotSucceeded do
  @derive Jason.Encoder
  defstruct [:snapshot_id, :payload]
end
