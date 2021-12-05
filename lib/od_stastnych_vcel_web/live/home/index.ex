defmodule OdStastnychVcelWeb.Live.Home.Index do
  @moduledoc false

  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Gallery
  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Live.Components.Button
  alias OdStastnychVcelWeb.Live.Components.Icons
  alias OdStastnychVcelWeb.Live.Components.Photo
  alias OdStastnychVcelWeb.Live.Components.Product
  alias OdStastnychVcelWeb.Live.Components.Section
  alias OdStastnychVcelWeb.Live.Components.Wave

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
