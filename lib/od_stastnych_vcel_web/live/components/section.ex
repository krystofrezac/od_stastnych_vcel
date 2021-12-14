defmodule OdStastnychVcelWeb.Live.Components.Section do
  @moduledoc false

  use OdStastnychVcelWeb, :component

  @spec main(%{honey: boolean, top: any(), inner_block: any(), bottom: any()}) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    container_wrapper_class =
      case Map.has_key?(assigns, :honey) do
        true -> "bg-honey"
        _other -> []
      end

    ~H"""
    <section class={Map.get(assigns, :section_class)}>
      <%= if Map.has_key?(assigns, :top) do %>
        <%= render_slot(@top) %>
      <% end %>
      <div class={container_wrapper_class}>
        <div class="container mx-auto py-5">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
      <%= if Map.has_key?(assigns, :bottom) do %>
        <%= render_slot(@bottom) %>
      <% end %>
    </section>
    """
  end
end
