defmodule BeesWeb.Admin.Live.Users.Index do
  @moduledoc false

  use BeesWeb, [:live_view, :admin]

  alias Bees.Accounts

  alias BeesWeb.Admin.Live.Components.Card

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:users, Accounts.list_users())}
  end
end
