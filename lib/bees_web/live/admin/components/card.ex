defmodule BeesWeb.Admin.Live.Components.Card do
  @moduledoc false

  use BeesWeb, :component

  @spec with_shadow(%{inner_block: any(), title_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def with_shadow(assigns) do
    class = Map.get(assigns, :class, "")

    title_block = Map.get(assigns, :title)
    title_class = get_class(title_block, left: [true: "text-left"])

    ~H"""
    <div class={"card text-center shadow-2xl bg-white " <> class}>
      <div class="card-body">
        <%= if title_block do %>
          <h2 class={title_class}>
            <%= render_slot(title_block) %>
          </h2> 
        <% end %>
        <%= render_slot(@inner_block) %>
      </div>
    </div> 
    """
  end

  @spec actions(%{inner_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def actions(assigns) do
    ~H"""
    <div class="justify-center card-actions">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
