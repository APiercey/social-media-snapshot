defmodule SocialMediaIntegration.Application do
  use Commanded.Application,
    otp_app: :social_media_integration,
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
end
