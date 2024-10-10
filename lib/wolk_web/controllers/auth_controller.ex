defmodule WolkWeb.AuthController do
  use WolkWeb, :controller
  plug Ueberauth

  alias Wolk.Accounts.User
  alias Wolk.Repo

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    dbg(auth.extra.raw_info.user)
    user_data = %{name: auth.info.name, admin: auth.extra.raw_info.user["admin"]}

    case findOrCreateUser(user_data) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")

      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: "/")
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp findOrCreateUser(user_data) do
    changeset = User.changeset(%User{}, user_data)

    case Repo.get_by(User, name: changeset.changes.name) do
      nil ->
        IO.puts("User not found, creating new one")
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
