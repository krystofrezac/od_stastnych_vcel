defmodule BeesWeb.Admin.Live.Components.Tooltip do
  @moduledoc false

  use BeesWeb, :component

  @spec main(%{optional(:position) => String.t(), title: String.t()}) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    class = get_class(assigns, [position: [left: "tooltip-left"]], "tooltip")

    ~H"""
    <div data-tip={@title} class={class}>
      <%= render_block @inner_block %>
    </div>
    """
  end
end
