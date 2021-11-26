defmodule OdStastnychVcelWeb.Live.Components.Product do
  use Phoenix.Component

  alias OdStastnychVcel.Schemas.Product
  alias OdStastnychVcelWeb.Router.Helpers, as: Routes

  @spec small(%{product: %Product{}}) :: %Phoenix.LiveView.Rendered{}
  def small(assigns) do
    ~H"""
    <%= live_redirect to: Routes.product_index_path(@socket, :index, id: @product.id) do %>
      <div class="m-4 flex flex-col items-center block w-max">
        <img src={@product.image} class="w-24 h-32 desktop:w-36 desktop:h-48 rounded object-cover"/>
        <h3>
          <%= @product.name %>
        </h3>
      </div>
    <% end %>
    """
  end

  @spec large_header(%{product: %Product{}}) :: %Phoenix.LiveView.Rendered{}
  def large_header(assigns) do
    ~H"""
    <div class="bg-honey flex flex-col items-center pb-5">
      <img 
        src={@product.image}
        class="w-36 h-48 desktop:w-60 desktop:h-80 mt-5 rounded object-cover"
      />
      <h1 class="pt-5 font-bold">
        <%= @product.name %>
      </h1>
    </div>
    """
  end
end
