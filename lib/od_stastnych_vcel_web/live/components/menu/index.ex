defmodule OdStastnychVcelWeb.Live.Components.Menu do
  @moduledoc false

  use OdStastnychVcelWeb, :component

  alias OdStastnychVcelWeb.Live.Components.Menu.Desktop
  alias OdStastnychVcelWeb.Live.Components.Menu.Mobile

  @spec main(%{socket: Phoenix.LiveView.Socket.t()}) :: Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    menu_items = get_menu_items(assigns.socket)

    ~H"""
    <Mobile.main class="desktop:hidden" menu_items={menu_items} {assigns}/> 
    <Desktop.main class="hidden desktop:block" menu_items={menu_items} {assigns}/> 
    """
  end

  defp get_menu_items(socket) do
    [
      {"Hlavní stránka", Routes.home_index_path(socket, :index)},
      {"Produkty", Routes.products_index_path(socket, :index)},
      {"Fotografie", Routes.gallery_index_path(socket, :index)}
    ]
  end
end
