defmodule SocialMediaSnapshot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, args) do
    children =
      [
        social_media_snapshot_web_router_spec(),
        SocialMediaIntegration.Application,
        SocialMediaIntegration.Snapshots.SnapshotProjector,
        SocialMediaIntegration.Snapshots.SnapshotEventHandler,
        SocialMediaIntegration.Repo
      ] ++ maybe_mock_facebook_server(args)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SocialMediaSnapshot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp social_media_snapshot_web_router_spec do
    Plug.Cowboy.child_spec(
      scheme: :http,
      plug: SocialMediaSnapshotWeb.Router,
      options: [port: 4000]
    )
  end

  defp maybe_mock_facebook_server(args) do
    case args do
      [env: :test] ->
        [
          Plug.Cowboy.child_spec(
            scheme: :http,
            plug: FacebookGraphClient.MockServer,
            options: [port: 4433]
          )
        ]

      [_] ->
        []
    end
  end
end
