defmodule SocialMediaSnapshotWeb.Router do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(Ueberauth)
  plug(:match)
  plug(:dispatch)

  get("/hcheck", do: send_resp(conn, 200, "200 OK"))
  get("/favicon.ico", do: send_resp(conn, 200, ""))

  get "/auth/:provider/callback" do
    _token =
      conn
      |> Map.get(:assigns)
      |> Map.get(:ueberauth_auth)
      |> Map.get(:credentials)
      |> Map.get(:token)

    conn
    |> send_resp(200, "hello")
  end
end
