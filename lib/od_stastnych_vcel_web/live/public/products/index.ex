defmodule OdStastnychVcelWeb.Public.Live.Products.Index do
  @moduledoc false

  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Public.Live.Components.Product
  alias OdStastnychVcelWeb.Public.Live.Components.Section
  alias OdStastnychVcelWeb.Public.Live.Components.Wave

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, :products, Products.list_products())
    }
  end
end
