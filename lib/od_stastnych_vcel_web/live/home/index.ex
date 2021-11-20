defmodule OdStastnychVcelWeb.Live.Home.Index do
  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Live.Components.Button
  alias OdStastnychVcelWeb.Live.Components.Icons
  alias OdStastnychVcelWeb.Live.Components.Wave
  alias OdStastnychVcelWeb.Live.Components.Product

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:products, Products.list_products())
    }
  end
end
