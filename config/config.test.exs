use Mix.Config

config :social_media_snapshot, event_store_adapter: Commanded.EventStore.Adapters.InMemory

config :social_media_snapshot, Commanded.EventStore.Adapters.InMemory,
  serializer: Commanded.Serialization.JsonSerializer

config :mix_test_watch,
  clear: true

config :logger, level: :warn
