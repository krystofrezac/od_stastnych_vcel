defmodule BeesWeb.Admin.Live.Components.Modal do
  @moduledoc false

  use BeesWeb, :component

  alias Phoenix.LiveView.JS

  # Actions
  @spec open() :: struct()
  @spec open(nil | String.t()) :: struct()
  def open(id \\ nil) do
    to = get_selector(id)
    JS.add_class("modal-open", to: to)
  end

  @spec close() :: struct()
  @spec close(nil | String.t()) :: struct()
  def close(id \\ nil) do
    to = get_selector(id)
    JS.remove_class("modal-open", to: to)
  end

  # Components
  @spec main(%{
          optional(:id) => integer,
          optional(:on_close) => String.t() | (() -> any()),
          inner_block: any()
        }) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    id = Map.get(assigns, :id)
    on_close = Map.get(assigns, :on_close, close(id))

    open_class =
      Map.get(assigns, :open)
      |> case do
        nil -> ""
        false -> ""
        _other -> " modal-open"
      end

    ~H"""
      <div class={"modal#{open_class}"} id={id}>
        <div 
          class="modal-box" 
          phx-key="Escape" 
          phx-capture-click={on_close}
          phx-window-keydown={on_close}
          phx-key="escape"
        >
          <h3>
            <%= render_slot(@title) %>
          </h3> 
          <%= render_block(@inner_block) %>  
        </div>
      </div>
    """
  end

  @spec actions(%{inner_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def actions(assigns) do
    ~H"""
    <div class="modal-action"> 
      <%= render_block(@inner_block) %>
    </div>
    """
  end

  defp get_selector(id) do
    case id do
      nil -> ".modal"
      id -> "##{id}.modal "
    end
  end
end
