# Application.load(:social_media_snapshot)

# for app <- Application.spec(:social_media_snapshot, :applications) do
#   Application.ensure_all_started(app)
# end

ExUnit.start()
Application.ensure_all_started(:bypass)
