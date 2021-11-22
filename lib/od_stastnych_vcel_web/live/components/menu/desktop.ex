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
    <div class={@class <> " pb-16"}>
      <nav class="fixed w-full z-10">
        <div class="bg-honey p-5 flex justify-end z-20 relative">
          <%= for {title, link} <- @menu_items do %>
            <%= live_redirect to: link do %>
              <span class="text-xl px-2">
                <%= title %>
              </span>
            <% end %>
          <% end %>
        </div>
        <div class="h-2 w-full" style="background: rgb(0,0,0); background: linear-gradient(0deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.3) 100%);">
        </div>
      </nav>
    </div>
    """
  end
end
