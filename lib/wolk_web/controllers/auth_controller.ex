defmodule WolkWeb.AuthController do
  use WolkWeb, :controller
  plug Ueberauth

  alias Wolk.Accounts.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_data = %{name: auth.info.name, admin: auth.extra.raw_info.user["admin"]}

    case User.findOrCreateUser(user_data) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> put_session(:live_socket_id, "user_socket:#{user.id}")
        |> redirect(to: "/")

      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: "/")
    end
  end

  def signout(conn, _params) do
    WolkWeb.Endpoint.broadcast("users_socket:#{conn.assigns[:user].id}", "disconnect", %{})

    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
