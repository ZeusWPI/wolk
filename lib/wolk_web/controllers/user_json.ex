defmodule WolkWeb.UserJSON do
  alias Wolk.Accounts.User

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      name: user.name,
      admin: user.admin
    }
  end
end
