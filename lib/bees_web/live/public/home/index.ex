defmodule BeesWeb.Public.Live.Home.Index do
  @moduledoc false

  use BeesWeb, :live_view

  alias Bees.Gallery
  alias Bees.Products

  alias BeesWeb.Live.Components.Icons
  alias BeesWeb.Public.Live.Components.Button
  alias BeesWeb.Public.Live.Components.Photo
  alias BeesWeb.Public.Live.Components.Product
  alias BeesWeb.Public.Live.Components.Section
  alias BeesWeb.Public.Live.Components.Wave

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
