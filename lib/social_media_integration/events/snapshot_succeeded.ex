defmodule SocialMediaIntegration.Events.SnapshotSucceeded do
  @moduledoc """
    This is a test
  """
  @derive Jason.Encoder
  defstruct [:snapshot_id, :payload]
end
