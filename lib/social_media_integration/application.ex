defmodule SocialMediaIntegration.Application do
  use Commanded.Application, otp_app: :social_media_snapshot

  alias SocialMediaIntegration.Router

  router(Router)
end
