defmodule WolkWeb.AlbumLive do
  use WolkWeb, :live_view

  def render(assigns) do
    ~H"""
    <.svelte name="Album" socket={@socket} />
    """
  end
end
