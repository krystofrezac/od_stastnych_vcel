defmodule OdStastnychVcelWeb.Live.Components.Menu do
  use Phoenix.Component

alias OdStastnychVcelWeb.Live.Components.Menu.Mobile
alias OdStastnychVcelWeb.Live.Components.Menu.Desktop

  @spec main(%{socket: %Phoenix.LiveView.Socket{}}) :: %Phoenix.LiveView.Rendered{}
  def main(assigns) do
    ~H"""
    <Mobile.main nav_class="desktop:hidden" {assigns}/> 
    <Desktop.main nav_class="sm:hidden desktop:block" {assigns}/> 
    """
  end
end
