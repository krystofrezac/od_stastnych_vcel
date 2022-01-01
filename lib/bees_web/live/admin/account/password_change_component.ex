defmodule BeesWeb.Admin.Live.Account.PasswordChangeComponent do
  @moduledoc false

  use BeesWeb, :live_component

  import Ecto.Changeset

  alias Bees.Accounts

  alias BeesWeb.Admin.Live.Components.Card
  alias BeesWeb.Admin.Live.Components.Form

  @impl Phoenix.LiveComponent
  def mount(socket) do
    {
      :ok,
      socket
      |> assign(:changeset, normalize_password(%{}))
    }
  end

  @impl Phoenix.LiveComponent
  def handle_event("password_change", %{"password" => password}, socket) do
    changeset =
      normalize_password(password)
      |> Map.put(:action, :change)

    {
      :noreply,
      socket
      |> assign(:changeset, changeset)
    }
  end

  @impl Phoenix.LiveComponent
  def handle_event("password_submit", %{"password" => password}, socket) do
    changeset = normalize_password(password)
    user = socket.assigns.current_user

    with {:ok, data} <- apply_action(changeset, :submit),
         {:ok, _user} <- Accounts.update_user_password(user, data.current_password, password) do
      {
        :noreply,
        socket
        |> put_flash(:info, "Heslo úspěšně změněno")
        |> redirect(Routes.user_session_path(socket, :new))
      }
    else
      {:error, changeset} ->
        {
          :noreply,
          socket
          |> assign(:changeset, changeset)
        }
    end
  end

  defp normalize_password(params) do
    types = %{current_password: :string, password: :string, password_confirmation: :string}

    {%{}, types}
    |> cast(params, Map.keys(types))
    |> validate_required([:current_password, :password, :password_confirmation])
  end
end
