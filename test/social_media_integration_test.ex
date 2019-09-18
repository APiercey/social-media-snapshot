defmodule SocialMediaSnapshot.IntegrationCase do
  @moduledoc """
  """

  use ExUnit.CaseTemplate
  alias Commanded.EventStore.Adapters.InMemory

  setup tags do
    # If Ecto is needed, don't forget to switch to sandbox mode and stop the app
    :ok = Application.stop(:social_media_snapshot_integration)

    {:ok, _apps} = Application.ensure_all_started(:social_media_snapshot_integration)
  end
end
