defmodule WolkWeb.AuthController do
  use WolkWeb, :controller
  plug Ueberauth

  alias Wolk.Accounts

  action_fallback WolkWeb.FallbackController

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_data = %{name: auth.info.name, admin: auth.extra.raw_info.user["admin"]}

    case Accounts.find_or_create_user(user_data) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")

      {:error, _} ->
        conn
        |> redirect(to: "/")
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
