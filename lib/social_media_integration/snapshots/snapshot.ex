defmodule SocialMediaIntegration.Snapshots.Snapshot do
  use Ecto.Schema

  schema "snapshots" do
    field(:uuid, :string)
    field(:user_id, :string)
    field(:status, :string)
  end
end
