use Mix.Config

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, []}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

config :social_media_snapshot, SocialMediaIntegration.Application,
  event_store: [
    adapter: Commanded.EventStore.Adapters.Extreme,
    serializer: Commanded.Serialization.JsonSerializer,
    stream_prefix: "social_media_snapshot",
    extreme: [
      db_type: :node,
      host: "localhost",
      port: 1113,
      username: "admin",
      password: "changeit",
      reconnect_delay: 2_000,
      max_attempts: :infinity
    ]
  ]

config :social_media_snapshot, SocialMediaIntegration.Repo,
  database: "snapshots",
  username: "postgres",
  hostname: "localhost"

config :social_media_snapshot,
  ecto_repos: [SocialMediaIntegration.Repo]

config :social_media_snapshot,
  facebook_base_url: "https://graph.facebook.com"

import_config "config.#{Mix.env()}.exs"
