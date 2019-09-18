defmodule SocialMediaSnapshot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: SocialMediaSnapshotWeb.Router,
        options: [port: 4000]
      ),
      SocialMediaIntegration.Application
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SocialMediaSnapshot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
