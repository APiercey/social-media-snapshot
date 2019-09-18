defmodule FacebookGraphClientTest do
  use ExUnit.Case

  alias FacebookGraphClient.{FacebookGraphRequest, FacebookGraphResponse}

  @valid_config_params [
    token:
      "EAAKjdnitRS0BAGKbEfWTZAtYyJGO172lMMLEsTYYoZB7xGDqVBJ1ny3TkmYRQjpv8xZBlo4LBiybROyZB2VwTfVgLKi6pcMDqtMLYbGnyHvezGdDdejcOK37Drx0Wv6xYkabUTYwz7NVaaXRaQa9ZAXAOt1gaZB9fHQoEElP5klyYhegNUHcYvoZCXlIjo1Fq4aQYshd8JeaLqgmFzef8TR",
    user_id: "110584387001977"
  ]

  describe "configure/1" do
    test "provides a %FacebookGraphRequest{}" do
      assert %FacebookGraphRequest{} = FacebookGraphClient.new(@valid_config_params)
    end
  end

  describe "fetch_user_information/1" do
    setup do
      request = FacebookGraphClient.new(@valid_config_params) |> IO.inspect()

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
