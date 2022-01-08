defmodule BeesWeb.Admin.LayoutView do
  use BeesWeb, [:view, :admin]

  alias BeesWeb.Admin.LayoutView.Flash

  alias BeesWeb.Live.Components.Icons

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  @spec menu(Phoenix.LiveView.Socket.t()) ::
          list({String.t(), Phoenix.LiveView.Rendered.t(), String.t(), Keyword.t()})
  def menu(socket) do
    Enum.map(menu_list(socket), fn item ->
      case tuple_size(item) do
        4 ->
          item

        3 ->
          {title, icon, link} = item
          {title, icon, link, []}
      end
    end)
  end

  @dialyzer {:no_match, menu_list: 1}
  defp menu_list(socket) do
    assigns = %{}

    [
      {"Přehled", ~H"<Icons.home/>", Routes.dashboard_index_path(socket, :index)},
      {"Uživatelé", ~H"<Icons.users/>", Routes.users_index_path(socket, :index)}
    ]
  end
end
