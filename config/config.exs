use Mix.Config

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, []}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

# config :commanded,
#   event_store_adapter: Commanded.EventStore.Adapters.EventStore

# config :social_media_snapshot, SocialMediaSnapshot.EventStore,
#   serializer: Commanded.Serialization.JsonSerializer,
#   url: System.get_env("DATABASE_URL")

# config :social_media_integration, SocialMediaIntegration.Application,
