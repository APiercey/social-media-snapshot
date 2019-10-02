defmodule SocialMediaIntegration.Repo do
  use Ecto.Repo,
    otp_app: :social_media_snapshot,
    adapter: Ecto.Adapters.Postgres
end
