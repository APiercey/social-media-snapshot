defmodule SocialMediaIntegration.Snapshots.Snapshot do
  use Ecto.Schema

  schema "snapshots" do
    field(:uuid, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:status, :string)
  end
end
