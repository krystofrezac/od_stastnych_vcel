defmodule BeesWeb.Public.Live.Components.Menu.Mobile do
  @moduledoc false

  use BeesWeb, :component

  alias Phoenix.LiveView.JS

  @spec main(%{
          socket: Phoenix.LiveView.Socket.t(),
          class: String.t() | nil,
          menu_items: list({String.t(), String.t()})
        }) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    ~H"""
    <div class={@class}>
      <.buttons {assigns}/>
      <.menu {assigns}/>
    </div>
    """
  end

  defp buttons(assigns) do
    ~H"""
    <div class="fixed w-full flex justify-end z-20">
      <button 
        id="nav-open"
        phx-click={open()} 
      >
        <.with_blob> 
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </.with_blob>
      </button>
      <button 
        id="nav-close" 
        class="hidden" 
        phx-click={close()}
      >
        <.with_blob>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </.with_blob>
      </button>
    </div>
    """
  end

  defp menu(assigns) do
    ~H"""
    <div 
      id="nav-body" 
      class="hidden transition-200 transition-opacity fixed w-full h-full bg-black bg-opacity-95 flex flex-col justify-center items-center z-10 " 
    >
      <h2 class="text-honey pb-8 text-4xl">
        Menu
      </h2>

      <%= for {title, link} <- @menu_items do %>
        <%= live_redirect to: link, class: "mb-2" do %>
          <span class="text-white text-3xl">
            <%= title %>
          </span>
        <% end %>
      <% end %>
    </div>
    """
  end

  defp with_blob(assigns) do
    ~H"""
    <div class="relative flex items-center justify-center w-14 h-14">
      <div class="absolute top-0 left-0 w-14 h-14 flex items-center justify-center">
        <svg
          viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
          <path fill="white" d="M56.4,-17.8C64,4.9,54.6,33.6,33.7,49.5C12.9,65.4,-19.5,68.4,-38.9,54.2C-58.3,40,-64.6,8.5,-55.9,-15.8C-47.3,-40,-23.6,-57,0.4,-57.1C24.4,-57.2,48.9,-40.5,56.4,-17.8Z" transform="translate(100 100)" />
        </svg>
      </div>
      

      <div class="w-6 h-6 z-10">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp open do
    JS.remove_class("hidden", time: 200, to: "#nav-body")
    |> JS.add_class("transition-200", transition: "opacity-0", time: 0, to: "#nav-body")
    |> JS.add_class("hidden", to: "#nav-open")
    |> JS.remove_class("hidden", to: "#nav-close")
  end

  defp close do
    JS.add_class("hidden", transition: "opacity-0", time: 200, to: "#nav-body")
    |> JS.remove_class("hidden", to: "#nav-open")
    |> JS.add_class("hidden", to: "#nav-close")
  end
end
