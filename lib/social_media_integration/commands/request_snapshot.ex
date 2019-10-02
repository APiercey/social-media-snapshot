defmodule SocialMediaIntegration.Commands.RequestSnapshot do
  defstruct [:user_id, :token, :snapshot_uuid]

  def put_uuid(%__MODULE__{} = snapshot, uuid) do
    snapshot |> Map.put(:snapshot_uuid, uuid)
  end
end
