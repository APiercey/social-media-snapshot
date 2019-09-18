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

  # get "/hello/:test", params do
  #   IO.inspect(params)
  #   conn |> send_resp(200, "world")
  # end

  # get "/auth/:provider" do
  #   Ueberauth.Strategy.Helpers.callback_url(conn) |> IO.inspect()

  #   conn
  #   |> send_resp(200, "Hello")
  # end

  get "/auth/:provider/callback" do
    token =
      conn
      |> Map.get(:assigns)
      |> Map.get(:ueberauth_auth)
      |> IO.inspect()
      |> Map.get(:credentials)
      |> Map.get(:token)
      |> IO.inspect()

    conn
    |> send_resp(200, "hello")
  end

  post "/auth/:provider/callback" do
  end
end
