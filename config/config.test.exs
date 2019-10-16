use Mix.Config

config :social_media_snapshot,
  facebook_base_url: "http://localhost:4433"

config :social_media_snapshot,
  event_store_adapter: Commanded.EventStore.Adapters.InMemory

config :social_media_snapshot,
  test_user_id: "100042009185477"

config :social_media_snapshot,
  test_token:
    "EAAKjdnitRS0BAIX6DqB4uHLUZC3EPSiezBYII6PiEPoZB4LjBIUjtx8W1JJxRZC0suW2oWt7ZCYdgZCRWyywz2aGqfCrhwN1PNORQxXkA3M4ZAKYKu3lfc8sBSOk0RM0DtBdmyxuBinpQ4tyZCQwhgNLFrBz1vtem9UBebZCFugZAvJl914X17XpAzDbhMQwaKmdKpZBxLbFg4dwZDZD"

config :social_media_snapshot, Commanded.EventStore.Adapters.InMemory,
  serializer: Commanded.Serialization.JsonSerializer

config :mix_test_watch,
  clear: true

config :logger, level: :warn
