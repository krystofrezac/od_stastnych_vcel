defmodule BeesWeb.Admin.Live.Components.Card do
  @moduledoc false

  use BeesWeb, :component

  @spec with_shadow(%{inner_block: any(), title_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def with_shadow(assigns) do
    class = Map.get(assigns, :class, "")

    title_block = Map.get(assigns, :title)
    title_class = get_class(title_block, left: [true: "text-left"])

    top_actions_block = Map.get(assigns, :top_actions)

    ~H"""
    <div class={"card text-center shadow-2xl bg-white " <> class}>
      <div class="card-body">
        <div class="flex flex-col sm:flex-row">
          <%= if title_block do %>
            <h2 class={title_class}>
              <%= render_slot(title_block) %>
            </h2> 
          <% end %>
          <%= if top_actions_block do %>
            <div class="flex sm:justify-end w-full items-center pb-3">
              <%= render_slot(top_actions_block) %>
            </div>
          <% end %>
        </div>
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
