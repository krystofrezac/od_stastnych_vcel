defmodule OdStastnychVcelWeb.Live.Components.Menu do
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  alias OdStastnychVcelWeb.Router.Helpers, as: Routes

  def main(assigns) do
    ~H"""
    <nav>
      <.buttons {assigns}/>
      <.menu {assigns}/>
    </nav>
    """
  end

  defp buttons(assigns) do
    ~H"""
    <div class="fixed w-full flex justify-end z-50">
      <button 
        id="nav-open"
        class="rounded-full p-5 bg-menu-blob transform" 
        phx-click={open()} 
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>
      <button 
        id="nav-close" 
        class="hidden relative rounded-full p-5 bg-menu-blob w-6 h-6" 
        phx-click={close()}
      >
        <svg class="top-0 left-0 absolute" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
          <path fill="white" d="M56.4,-17.8C64,4.9,54.6,33.6,33.7,49.5C12.9,65.4,-19.5,68.4,-38.9,54.2C-58.3,40,-64.6,8.5,-55.9,-15.8C-47.3,-40,-23.6,-57,0.4,-57.1C24.4,-57.2,48.9,-40.5,56.4,-17.8Z" transform="translate(100 100)" />
        </svg>
        <div class="top-0 left-0 w-full h-full flex justify-center items-center absolute">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </div>
      </button>
    </div>
    """
  end

  defp menu(assigns) do
    ~H"""
    <div id="nav-body" class="hidden fixed w-full h-full bg-black bg-opacity-95 flex flex-col justify-center items-center z-40" x-show.transition.origin.top.right="navigation_open">
      <h2 class="text-honey pb-8 text-4xl">
        Menu
      </h2>
      <.menu_link value="Hlavni stranka"/> 
      <.menu_link value="Produkty"/> 
      <.menu_link value="Fotografie"/> 
    </div>
    """
  end

  defp menu_link(assigns) do
    ~H"""
    <span class="text-white text-3xl pb-2">
      <%= @value %>
    </span>
    """
  end

  defp open() do
    JS.remove_class("hidden", to: "#nav-body")
    |> JS.add_class("hidden", to: "#nav-open")
    |> JS.remove_class("hidden", to: "#nav-close")
  end

  defp close() do
    JS.add_class("hidden", to: "#nav-body")
    |> JS.remove_class("hidden", to: "#nav-open")
    |> JS.add_class("hidden", to: "#nav-close")
  end
end
