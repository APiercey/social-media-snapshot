defmodule SocialMediaIntegrationTest do
  use SocialMediaSnapshot.AcceptanceCase, async: false

  @token "EAAKjdnitRS0BAGKbEfWTZAtYyJGO172lMMLEsTYYoZB7xGDqVBJ1ny3TkmYRQjpv8xZBlo4LBiybROyZB2VwTfVgLKi6pcMDqtMLYbGnyHvezGdDdejcOK37Drx0Wv6xYkabUTYwz7NVaaXRaQa9ZAXAOt1gaZB9fHQoEElP5klyYhegNUHcYvoZCXlIjo1Fq4aQYshd8JeaLqgmFzef8TR"
  @user_id "110584387001977"

  describe "request_user_snapshot/1" do
    test "returns {:ok, %{}}" do
      assert {:ok, %{}} = SocialMediaIntegration.request_user_snapshot(@user_id, @token)
    end

    test "returns status: 'requested'" do
      {:ok, payload} = SocialMediaIntegration.request_user_snapshot(@user_id, @token)
      assert %{status: "requested"} = payload
    end

    test "returns user_id" do
      {:ok, payload} = SocialMediaIntegration.request_user_snapshot(@user_id, @token)
      assert %{user_id: @user_id} = payload
    end

    test "returns a id" do
      {:ok, payload} = SocialMediaIntegration.request_user_snapshot(@user_id, @token)
      assert %{id: id} = payload
      assert id |> is_bitstring
    end
  end

  describe "fetch_user_snapshot/1" do
    setup do
      {:ok, %{id: id}} = SocialMediaIntegration.request_user_snapshot(@user_id, @token)
      %{id: id}
    end

    test "returns {:ok, %{}}", %{id: id} do
      assert {:ok, %{}} = id |> SocialMediaIntegration.fetch_user_snapshot()
    end

    test "returns snapshot_id", %{id: id} do
      {:ok, payload} = id |> SocialMediaIntegration.fetch_user_snapshot()

      assert %{id: ^id} = payload
    end

    test "returns status: 'successful'", %{id: id} do
      assert fn ->
               {:ok, %{status: status}} = id |> SocialMediaIntegration.fetch_user_snapshot()
               status == "successful"
             end
             |> retry({3, 1000})
    end

    defp retry(fun, {attempts, sleep_time}) do
      1..attempts
      |> Enum.to_list()
      |> Enum.find(fn _ ->
        case fun.() do
          true ->
            true

          false ->
            :timer.sleep(sleep_time)
            false
        end
      end)
    end
  end
end
