defmodule OdStastnychVcelWeb.Live.Gallery.Index do
  @moduledoc false

  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Gallery

  alias OdStastnychVcelWeb.Live.Components.Photo
  alias OdStastnychVcelWeb.Live.Components.Section
  alias OdStastnychVcelWeb.Live.Components.Wave

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
