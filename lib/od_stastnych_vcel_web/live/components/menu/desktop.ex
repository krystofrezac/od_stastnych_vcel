defmodule OdStastnychVcelWeb.Live.Components.Menu.Desktop do
  @moduledoc false

  use OdStastnychVcelWeb, :component

  @spec main(%{
          socket: Phoenix.LiveView.Socket.t(),
          class: String.t() | nil,
          menu_items: list({String.t(), String.t()})
        }) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    ~H"""
    <div class={@class <> " sticky top-0 -mb-2 w-full z-10"}>
      <div class="bg-black bg-opacity-90 px-5 py-3 z-20 relative">
        <div class="container flex align-center mx-auto">
          <img 
            class="w-8 h-8"
            src={Routes.static_path(@socket, "/images/logo.svg")}
          />
          <span class="text-white text-2xl pl-5 my-auto">
            Od štastných včel 
          </span>
          <div class="flex justify-end ml-auto items-center">
            <%= for {title, link} <- @menu_items do %>
              <%= live_redirect to: link do %>
                <span class="text-xl pl-4 text-white">
                  <%= title %>
                </span>
              <% end %>
            <% end %>
          </div>
        </div>
      </div>
      <div class="h-2 w-full" style="background: rgb(0,0,0); background: linear-gradient(0deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.3) 100%);">
      </div>
    </div>
    """
  end
end
