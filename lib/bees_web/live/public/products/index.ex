defmodule BeesWeb.Public.Live.Products.Index do
  @moduledoc false

  use BeesWeb, :live_view

  alias Bees.Products

  alias BeesWeb.Public.Live.Components.Product
  alias BeesWeb.Public.Live.Components.Section
  alias BeesWeb.Public.Live.Components.Wave

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, :products, Products.list_products())
    }
  end
end
