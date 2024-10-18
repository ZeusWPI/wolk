defmodule WolkWeb.AlbumLive.Index do
  use WolkWeb, :live_view
  use LiveSvelte.Components
  alias Wolk.Album
  alias Wolk.Repo

  def render(assigns) do
    ~H"""
    <.svelte
      name="pages/AlbumGallery"
      props={%{admin: @user.admin, albums: @albums}}
      socket={@socket}
    />
    """
  end

  def mount(_params, _session, socket) do
    albums = Repo.all(Album)
    {:ok, assign(socket, :albums, albums)}
  end

  def handle_event("create_album", %{"album" => album_params}, socket) do
    case socket.assigns.user do
      nil ->
        {:noreply, socket}

      _user ->
        album = Album.changeset(%Album{}, album_params)

        case Repo.insert(album) do
          {:ok, album} ->
            {:noreply, assign(socket, albums: [album | socket.assigns.albums])}

          {:error, changeset} ->
            {:noreply, assign(socket, changeset: changeset)}
        end
    end
  end

  def handle_event(_event, _params, socket) do
    {:noreply, socket}
  end
end
