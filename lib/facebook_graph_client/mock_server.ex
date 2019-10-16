defmodule FacebookGraphClient.MockServer do
  @moduledoc """
  A mockserver used for testing
  """

  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  get "/:user_id" do
    {:ok, response} =
      %{
        id: user_id,
        first_name: "Steve",
        last_name: "Winston"
      }
      |> Poison.encode()

    conn
    |> Plug.Conn.send_resp(200, response)
  end
end
