defmodule OdStastnychVcelWeb.Live.Components.Product do
  use Phoenix.Component

  alias OdStastnychVcel.Schemas.Product
  alias OdStastnychVcelWeb.Router.Helpers, as: Routes

  @spec small(%{product: %Product{}}) :: %Phoenix.LiveView.Rendered{}
  def small(assigns) do
    ~H"""
    <%= live_redirect to: Routes.product_index_path(@socket, :index, id: @product.id) do %>
      <div class="m-4 flex flex-col items-center">
        <img src={@product.image} class="w-24 h-32 rounded object-cover"/>
        <h3>
          <%= @product.name %>
        </h3>
      </div>
    <% end %>
    """
  end
end
