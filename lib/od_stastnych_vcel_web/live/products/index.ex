defmodule OdStastnychVcelWeb.Live.Products.Index do
  @moduledoc false

  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Live.Components.Product
  alias OdStastnychVcelWeb.Live.Components.Section
  alias OdStastnychVcelWeb.Live.Components.Wave

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, :products, Products.list_products())
    }
  end
end
