defmodule WolkWeb.LiveHoofdje do
  use WolkWeb, :live_view
  use LiveSvelte.Components

  def render(assigns) do
    ~H"""
    <.svelte name="Hoofdje" socket={@socket} />
    """
  end
end
