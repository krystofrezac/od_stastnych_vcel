defmodule BeesWeb.Admin.Live.Users.Index do
  @moduledoc false

  use BeesWeb, [:live_view, :admin]

  import Ecto.Changeset

  alias Bees.Accounts

  alias BeesWeb.Admin.Live.Components.Card
  alias BeesWeb.Admin.Live.Components.Form
  alias BeesWeb.Admin.Live.Components.Modal
  alias BeesWeb.Admin.Live.Components.Tooltip
  alias BeesWeb.Live.Components.Icons

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:users, Accounts.list_users())
      |> assign(:add_changeset, normalize_add_data())
      |> assign(:delete_user, nil)
    }
  end

  def handle_event("delete_cancel", _params, socket) do
    {
      :noreply,
      socket
      |> assign(:delete_user, nil)
    }
  end

  def handle_event("delete", %{"user" => user}, socket) do
    {
      :noreply,
      socket
      |> assign(:delete_user, Accounts.get_user!(user))
    }
  end

  @impl Phoenix.LiveView
  def handle_event("delete_confirm", _params, socket) do
    socket.assigns.delete_user
    |> Accounts.delete_user()

    {
      :noreply,
      socket
      |> assign(:users, Accounts.list_users())
      |> assign(:delete_user, nil)
      |> put_flash(:info, "Uživatel úspěšně odstraněn")
    }
  end

  @impl Phoenix.LiveView
  def handle_event("change", %{"add" => params}, socket) do
    changeset =
      normalize_add_data(params)
      |> Map.put(:action, :change)

    {
      :noreply,
      socket
      |> assign(:add_changeset, changeset)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("submit", %{"add" => params}, socket) do
    case Accounts.register_user(params, Routes.user_session_url(socket, :new)) do
      {:ok, _user} ->
        Modal.close()

        {
          :noreply,
          socket
          |> put_flash(:info, "Email o registraci úspěšně odeslán")
        }

      {:error, changeset} ->
        {
          :noreply,
          socket
          |> assign(:add_changeset, changeset)
        }
    end
  end

  defp normalize_add_data(params \\ %{}) do
    types = %{email: :string}

    {%{}, types}
    |> cast(params, Map.keys(types))
    |> validate_required([:email])
  end
end
