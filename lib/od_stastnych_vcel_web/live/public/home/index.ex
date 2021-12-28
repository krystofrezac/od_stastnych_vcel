defmodule OdStastnychVcelWeb.Public.Live.Home.Index do
  @moduledoc false

  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Gallery
  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Public.Live.Components.Button
  alias OdStastnychVcelWeb.Public.Live.Components.Icons
  alias OdStastnychVcelWeb.Public.Live.Components.Photo
  alias OdStastnychVcelWeb.Public.Live.Components.Product
  alias OdStastnychVcelWeb.Public.Live.Components.Section
  alias OdStastnychVcelWeb.Public.Live.Components.Wave

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:products, Products.list_products_for_home_page())
      |> assign(:photos, Gallery.list_photos_for_home_page())
    }
  end
end
