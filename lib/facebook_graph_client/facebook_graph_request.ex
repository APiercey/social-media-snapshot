defmodule FacebookGraphClient.FacebookGraphRequest do
  defstruct [:properties, :token, :user_id]

  def new(token: _token, user_id: _user_id) do
    %__MODULE__{}
  end
end
