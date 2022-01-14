defmodule BeesWeb.Admin.Live.Components.Modal.LiveComponent do
  @moduledoc false

  use BeesWeb, :live_component

  alias Phoenix.LiveView.JS

  @impl Phoenix.LiveComponent
  def mount(socket) do
    {
      :ok,
      socket
      |> assign(:open, false)
      |> assign(:close, false)
    }
  end

  @impl Phoenix.LiveView
  def update(assigns, socket) do
    socket =
      case assigns.open do
        false -> socket
        nil -> socket
        _ -> assign(socket, :open, true) |> assign(:close, false)
      end

    socket =
      case assigns.open do
        false -> assign(socket, :close, true)
        nil -> assign(socket, :close, true)
        _ -> socket
      end

    assigns = Map.delete(assigns, :open)

    {
      :ok,
      socket
      |> assign(assigns)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("close", _params, socket) do
    {
      :noreply,
      socket
      |> assign(:close, false)
      |> assign(:open, false)
    }
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= if @open do %>
        <div
          id={"modal-close-hook-#{@id}"}
          phx-hook="exec_js"
          exec={@close}
          exec-js={close(@myself)}
        >
        </div>
        <div 
          id={"modal-#{@id}"}
          class="modal visible pt-10 sm:pt-0" 
          phx-hook="on_mount_exec_js" 
          on-mount-js={open()}
        >
          <div 
            class={"modal-box max-h-full overflow-y-auto"} 
            phx-key="Escape" 
            phx-capture-click={@on_close}
            phx-window-keydown={@on_close}
            phx-key="escape"
          >
            <h3>
              <%= render_slot(@title) %>
            </h3> 
            <%= render_block(@inner_block) %>  
          </div>
        </div>
    <% end %>
    </div>
    """
  end

  @spec open() :: struct()
  def open() do
    JS.add_class("modal-open", to: ".modal")
    |> JS.remove_class("invisible", to: ".modal > .modal-box")
  end

  @spec close(pid()) :: struct()
  def close(myself) do
    JS.remove_class("modal-open", to: ".modal")
    |> JS.add_class("invisible", to: ".modal > .modal-box", transition: "_", time: 200)
    |> JS.push("close", target: myself)
  end
end
