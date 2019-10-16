defmodule SocialMediaIntegrationTest do
  use SocialMediaSnapshot.AcceptanceCase, async: false

  describe "request_user_snapshot/1" do
    setup do
      %{
        user_id: Ecto.UUID.generate(),
        token: Ecto.UUID.generate()
      }
    end

    test "returns {:ok, %{}}", %{user_id: user_id, token: token} do
      assert {:ok, %{}} = SocialMediaIntegration.request_user_snapshot(user_id, token)
    end

    test "returns status: 'requested'", %{user_id: user_id, token: token} do
      {:ok, payload} = SocialMediaIntegration.request_user_snapshot(user_id, token)
      assert %{status: "requested"} = payload
    end

    test "returns a id", %{user_id: user_id, token: token} do
      {:ok, payload} = SocialMediaIntegration.request_user_snapshot(user_id, token)
      assert %{id: id} = payload
      assert id |> is_bitstring
    end
  end

  describe "fetch_user_snapshot/1" do
    setup do
      {:ok, %{id: id}} =
        SocialMediaIntegration.request_user_snapshot(Ecto.UUID.generate(), Ecto.UUID.generate())

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

    test "returns first_name", %{id: id} do
      wait_until_successful(id)
      {:ok, %{first_name: first_name}} = id |> SocialMediaIntegration.fetch_user_snapshot()

      assert first_name |> String.trim() != ""
    end

    test "returns last_name", %{id: id} do
      wait_until_successful(id)
      {:ok, %{last_name: last_name}} = id |> SocialMediaIntegration.fetch_user_snapshot()

      assert last_name |> String.trim() != ""
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

    defp wait_until_successful(id) do
      assert fn ->
               {:ok, %{status: status}} = id |> SocialMediaIntegration.fetch_user_snapshot()
               status == "successful"
             end
             |> retry({3, 1000})
    end
  end
end
