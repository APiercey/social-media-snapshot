defmodule FacebookGraphClient.FacebookGraphRequestTest do
  use ExUnit.Case

  alias FacebookGraphClient.FacebookGraphRequest

  @params [
    token: "token",
    user_id: "user_id"
  ]

  describe "new/1" do
    test "returns a %FacebookGraphRequest{}" do
      assert %FacebookGraphRequest{} = FacebookGraphRequest.new(@params)
    end

    test "returns correct token" do
      assert %{token: "token"} = FacebookGraphRequest.new(@params)
    end

    test "returns correct user_id" do
      assert %{user_id: "user_id"} = FacebookGraphRequest.new(@params)
    end
  end
end
