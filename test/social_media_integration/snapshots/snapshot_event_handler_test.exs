defmodule SocialMediaIntegration.Snapshots.SnapshotEventHandlerTest do
  use ExUnit.Case
  alias Ecto.UUID
  import Commanded.Assertions.EventAssertions

  describe "handle/2 failures" do
    test "rejects snapshot with failing Facebook request" do
      request_snapshot("asd", "asd")

      assert_receive_event(
        SocialMediaIntegration.Application,
        SocialMediaIntegration.Events.SnapshotRequested,
        fn event ->
          assert event |> IO.inspect()
        end
      )
    end

    defp request_snapshot(user_id, token) do
      uuid = UUID.generate()

      %SocialMediaIntegration.Commands.RequestSnapshot{
        user_id: user_id,
        token: token,
        snapshot_uuid: uuid
      }
      |> SocialMediaIntegration.Application.dispatch(consistency: :strong)
    end
  end
end
