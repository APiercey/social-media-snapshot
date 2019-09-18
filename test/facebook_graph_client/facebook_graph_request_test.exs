defmodule FacebookGraphClient.FacebookGraphRequestTest do
  use ExUnit.Case

  alias FacebookGraphClient.FacebookGraphRequest

  @params [
    token: "token",
    user_id: "user_id"
  ]

  describe "new/1" do
    test "returns a %FacebookGraphRequest{}", request do
      assert %FacebookGraphRequest{} = FacebookGraphRequest.new(@params)
    end

    test "returns correct token", request do
      assert %{token: "token"} = FacebookGraphRequest.new(@params)
    end

    test "returns correct user_id", request do
      assert %{user_id: _} = FacebookGraphRequest.new(@params)
    end
  end
end
