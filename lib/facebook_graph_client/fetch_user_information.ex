defmodule FacebookGraphClient.FetchUserInformation do
  alias FacebookGraphClient.{FacebookGraphRequest, FacebookGraphResponse}

  @base_url Application.get_env(:social_media_snapshot, :facebook_base_url)
  @properties "id,name,about,last_name,link,short_name,video_upload_limits,languages,gender,first_name"

  def call(%FacebookGraphRequest{token: token, user_id: user_id}) do
    fetch(token, user_id)
    |> pluck_body
    |> to_response
  end

  defp fetch(token, user_id) do
    "#{@base_url}/#{user_id}?fields=#{@properties}&access_token=#{token}"
    |> HTTPoison.get()
  end

  defp pluck_body({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Jason.decode(body)
  end

  defp pluck_body({:ok, %HTTPoison.Response{body: body}}), do: {:error, Jason.decode!(body)}

  defp pluck_body(error), do: {:error, error}

  defp to_response(
         {:ok,
          %{
            "first_name" => first_name,
            "last_name" => last_name,
            "id" => id
          }}
       ) do
    response = %FacebookGraphResponse{
      user_data: %{first_name: first_name, last_name: last_name, user_id: id}
    }

    {:ok, response}
  end

  defp to_response(error), do: error
end
