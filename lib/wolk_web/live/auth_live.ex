defmodule WolkWeb.UserLiveAuth do
  import Phoenix.Component
  import Phoenix.LiveView
  alias Wolk.Accounts.User
  alias Wolk.Repo

  def on_mount(:default, _params, %{"user_id" => user_id} = _session, socket) do
    socket =
      assign_new(socket, :user, fn ->
        cond do
          user = user_id && Repo.get(User, user_id) ->
            user

          true ->
            nil
        end
      end)

    if socket.assigns.user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/auth/zauth")}
    end
  end

  def on_mount(:default, _params, _session, socket) do
    {:halt, redirect(socket, to: "/auth/zauth")}
  end
end
