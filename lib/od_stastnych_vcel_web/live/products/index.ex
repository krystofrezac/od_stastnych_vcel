defmodule OdStastnychVcelWeb.Live.Products.Index do
  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Products
  alias OdStastnychVcelWeb.Live.Components.Wave
  alias OdStastnychVcelWeb.Live.Components.Product
  alias OdStastnychVcelWeb.Live.Components.Section

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:products, Products.list_products())
    }
  end
end
