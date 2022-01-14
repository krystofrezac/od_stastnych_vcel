defmodule BeesWeb.Admin.Live.Components.Modal do
  @moduledoc false

  use BeesWeb, :component


  alias BeesWeb.Admin.Live.Components.Modal.LiveComponent

  # Components
  @spec main(%{
          optional(:on_close) => String.t() | (() -> any()),
          id: integer(),
          inner_block: any()
        }) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    live_component(Map.merge(%{module: LiveComponent}, assigns))
  end

  @spec actions(%{inner_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def actions(assigns) do
    ~H"""
    <div class="modal-action"> 
      <%= render_block(@inner_block) %>
    </div>
    """
  end
end
