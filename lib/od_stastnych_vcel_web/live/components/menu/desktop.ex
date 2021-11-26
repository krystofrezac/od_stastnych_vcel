defmodule OdStastnychVcelWeb.Live.Components.Menu.Desktop do
  use Phoenix.Component

  @spec main(%{
          socket: %Phoenix.LiveView.Socket{},
          class: String.t() | nil,
          menu_items: list({String.t(), String.t()})
        }) ::
          %Phoenix.LiveView.Rendered{}
  def main(assigns) do
    ~H"""
    <div class={@class <> " sticky top-0 -mb-2 w-full z-10"}>
      <div class="bg-black bg-opacity-90 py-5 z-20 relative">
        <div class="container m-auto flex justify-end">
          <%= for {title, link} <- @menu_items do %>
            <%= live_redirect to: link do %>
              <span class="text-xl pl-4 text-white">
                <%= title %>
              </span>
            <% end %>
          <% end %>
        </div>
      </div>
      <div class="h-2 w-full" style="background: rgb(0,0,0); background: linear-gradient(0deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.3) 100%);">
      </div>
    </div>
    """
  end
end
