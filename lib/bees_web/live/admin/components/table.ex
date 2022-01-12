defmodule BeesWeb.Admin.Live.Components.Table do
  @moduledoc false

  use BeesWeb, :component

  alias BeesWeb.Admin.Live.Components.Tooltip
  alias BeesWeb.Live.Components.Icons

  @spec main(%{inner_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    ~H"""
    <div class="overflow-x-auto">
      <table class="table w-full overflow"> 
        <%= render_block @inner_block %>
      </table>
    </div>
    """
  end

  @spec actions_head(%{}) :: Phoenix.LiveView.Rendered.t()
  def actions_head(assigns) do
    ~H"""
    <th/> 
    """
  end

  @spec actions(%{inner_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def actions(assigns) do
    ~H"""
    <td class="text-right flex gap-2 justify-end"> 
      <%= render_block @inner_block %>
    </td>
    """
  end

  @spec action(%{icon: String.t(), tooltip: String.t(), type: String.t()}) ::
          Phoenix.LiveView.Rendered.t()
  def action(assigns) do
    icon = apply(Icons, String.to_existing_atom("#{assigns.icon}"), [%{size: "sm"}])

    button_assigns =
      Map.filter(assigns, fn {key, _value} ->
        !Enum.member?([:icon, :tooltip, :type, :__slot__, :inner_block], key)
      end)

    ~H"""
    <Tooltip.main 
      title={@tooltip}
      position="left"

    >
      <button 
        class={"btn btn-square btn-sm btn-outline btn-#{@type}"}
        {button_assigns}
      >
        <%= icon %>
      </button>
    </Tooltip.main>
    """
  end
end
