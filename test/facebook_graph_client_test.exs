defmodule FacebookGraphClientTest do
  use ExUnit.Case

  alias FacebookGraphClient.{FacebookGraphRequest, FacebookGraphResponse}

  @valid_token Application.get_env(:social_media_snapshot, :test_token)
  @valid_user_id Application.get_env(:social_media_snapshot, :test_user_id)

  describe "configure/1" do
    test "provides a %FacebookGraphRequest{}" do
      assert %FacebookGraphRequest{} =
               [token: @valid_token, user_id: @valid_user_id] |> FacebookGraphClient.new()
    end
  end

  describe "fetch_user_information/1" do
    setup do
      request = [token: @valid_token, user_id: @valid_user_id] |> FacebookGraphClient.new()

      %{request: request}
    end

    test "returns {:ok, %FacebookGraphResponse{}}", %{request: request} do
      assert {:ok, %FacebookGraphResponse{}} =
               request |> FacebookGraphClient.fetch_user_information()
    end

    test "returns first_name", %{request: request} do
      expected_property = :first_name

      assert request
             |> FacebookGraphClient.fetch_user_information()
             |> pluck_user_value(expected_property)
             |> is_bitstring
    end

    test "returns last_name", %{request: request} do
      expected_property = :last_name

      assert request
             |> FacebookGraphClient.fetch_user_information()
             |> pluck_user_value(expected_property)
             |> is_bitstring
    end

    test "returns user_id", %{request: request} do
      expected_property = :user_id

      assert request
             |> FacebookGraphClient.fetch_user_information()
             |> pluck_user_value(expected_property)
             |> is_bitstring
    end

    defp pluck_user_value({:ok, %{user_data: user_data}}, property) do
      user_data |> Map.get(property)
    end
  end
end
