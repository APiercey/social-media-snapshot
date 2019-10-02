defmodule FacebookGraphClient.FetchUserInformation do
  alias FacebookGraphClient.{FacebookGraphRequest, FacebookGraphResponse}

  def call(%FacebookGraphRequest{token: token, user_id: user_id}) do
    fetch(token, user_id)

    {:ok,
     %FacebookGraphResponse{user_data: %{first_name: "test", last_name: "test", user_id: "id"}}}
  end

  defp fetch(token, user_id) do
    HTTPoison.get("https://graph.facebook.com/#{user_id}?access_token=#{token}")
  end
end
