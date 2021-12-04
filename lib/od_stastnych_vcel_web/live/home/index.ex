defmodule OdStastnychVcelWeb.Live.Home.Index do
  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Products
  alias OdStastnychVcel.Gallery

  alias OdStastnychVcelWeb.Live.Components.Button
  alias OdStastnychVcelWeb.Live.Components.Icons
  alias OdStastnychVcelWeb.Live.Components.Wave
  alias OdStastnychVcelWeb.Live.Components.Product
  alias OdStastnychVcelWeb.Live.Components.Section
  alias OdStastnychVcelWeb.Live.Components.Photo

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:products, Products.list_products())
      |> assign(:photos, Gallery.list_photos_for_home_page())
    }
  end
end
