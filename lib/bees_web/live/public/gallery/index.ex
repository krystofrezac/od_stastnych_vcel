defmodule BeesWeb.Public.Live.Gallery.Index do
  @moduledoc false

  use BeesWeb, :live_view

  alias Bees.Gallery

  alias BeesWeb.Public.Live.Components.Photo
  alias BeesWeb.Public.Live.Components.Section
  alias BeesWeb.Public.Live.Components.Wave

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:photos, Gallery.list_photos())
      |> assign(:opened, nil)
    }
  end

  @impl Phoenix.LiveView
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :action, :index)
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:action, :show)
    |> assign(:photo, Gallery.get_photo(String.to_integer(id)))
  end
end
