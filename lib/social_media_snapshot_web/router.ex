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
    with token <- pluck_token(conn),
         uid <- pluck_uid(conn),
         {:ok, snapshot} <- SocialMediaIntegration.request_user_snapshot(uid, token),
         {:ok, payload} <- Jason.encode(snapshot) do
      conn |> send_resp(200, payload)
    end
  end

  get "/snapshots/:id" do
    with {:ok, snapshot} <- SocialMediaIntegration.fetch_user_snapshot(id),
         {:ok, payload} <- Jason.encode(snapshot) do
      conn |> send_resp(200, payload)
    end
  end

  get "/snapshots" do
    with {:ok, snapshots} <- SocialMediaIntegration.fetch_user_snapshots(),
         {:ok, payload} <- Jason.encode(snapshots) do
      conn |> send_resp(200, payload)
    end
  end

  defp pluck_token(%Plug.Conn{} = plug_conn) do
    plug_conn
    |> Map.get(:assigns)
    |> Map.get(:ueberauth_auth)
    |> Map.get(:credentials)
    |> Map.get(:token)
  end

  defp pluck_uid(%Plug.Conn{} = plug_conn) do
    plug_conn
    |> Map.get(:assigns)
    |> Map.get(:ueberauth_auth)
    |> Map.get(:uid)
  end
end
