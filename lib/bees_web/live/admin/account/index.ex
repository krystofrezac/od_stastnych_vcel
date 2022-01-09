defmodule BeesWeb.Admin.Live.Account.Index do
  @moduledoc false

  use BeesWeb, [:live_view, :admin]

  alias BeesWeb.Admin.Live.Components.Card

  alias BeesWeb.Admin.Live.Account.DataChangeComponent
  alias BeesWeb.Admin.Live.Account.EmailChangeComponent
  alias BeesWeb.Admin.Live.Account.PasswordChangeComponent

  @impl Phoenix.LiveView
  def handle_params(_params, url, socket) do
    {:noreply, socket |> assign(:url, url)}
  end
end
