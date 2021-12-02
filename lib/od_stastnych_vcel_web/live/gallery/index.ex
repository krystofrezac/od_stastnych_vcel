defmodule OdStastnychVcelWeb.Live.Gallery.Index do
  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Gallery

  alias OdStastnychVcelWeb.Live.Components.Section
  alias OdStastnychVcelWeb.Live.Components.Wave
  alias OdStastnychVcelWeb.Live.Components.Photo

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:photos, Gallery.list_photos())
      |> assign(:opened, nil)
    }
  end

  @impl true
  def handle_event("open", %{"id" => id}, socket) do
    {
      :noreply,
      socket |> assign(:opened, Gallery.get_photo(String.to_integer(id)))
    }
  end

  @impl true
  def handle_event("close", _params, socket) do
    {
      :noreply,
      socket |> assign(:opened, nil)
    }
  end
end
