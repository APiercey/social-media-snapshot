defmodule SocialMediaSnapshotWeb.Router do
  use Plug.Router

  plug(Ueberauth)
  plug(:match)
  plug(:dispatch)

  get("/hcheck", do: send_resp(conn, 200, "200 OK"))
  get("/favicon.ico", do: send_resp(conn, 200, ""))

  get "/auth/:provider" do
    Ueberauth.Strategy.Helpers.callback_url(conn) |> IO.inspect()

    conn
    |> send_resp(200, "Hello")
  end

  get "/:provider/callback" do
  end

  post "/:provider/callback" do
  end
end
