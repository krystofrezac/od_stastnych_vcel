defmodule OdStastnychVcelWeb.Live.Products.Index do
  use OdStastnychVcelWeb, :live_view

  alias OdStastnychVcelWeb.Live.Components.Wave

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
