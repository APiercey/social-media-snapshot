defmodule FacebookGraphClient do
  alias FacebookGraphClient.{FacebookGraphRequest, FetchUserInformation}

  defdelegate new(opts),
    to: FacebookGraphRequest,
    as: :new

  defdelegate fetch_user_information(request),
    to: FetchUserInformation,
    as: :call
end
