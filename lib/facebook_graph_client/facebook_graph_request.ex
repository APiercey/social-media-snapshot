defmodule FacebookGraphClient.FacebookGraphRequest do
  @properties [:token, :user_id]
  defstruct @properties

  def new(params), do: __MODULE__ |> struct(params)
end
