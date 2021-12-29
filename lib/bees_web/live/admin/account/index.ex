defmodule BeesWeb.Admin.Live.Account.Index do
  @moduledoc false

  use BeesWeb, [:live_view, :admin]

  import Ecto.Changeset

  alias Bees.Accounts

  alias BeesWeb.Admin.Live.Components.Card
  alias BeesWeb.Admin.Live.Components.Form

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:email_changeset, change_email(%{}))
      |> assign(:password_changeset, change_password(%{}))
    }
  end

  @impl Phoenix.LiveView
  def handle_event(
        "email_change",
        %{"email_change" => email_change},
        socket
      ) do
    email_changeset =
      change_email(email_change)
      |> Map.put(:action, :change)

    {:noreply, socket |> assign(:email_changeset, email_changeset)}
  end

  @impl Phoenix.LiveView
  @dialyzer {:no_match, handle_event: 3}
  def handle_event(
        "email_submit",
        %{"email_change" => email_change},
        socket
      ) do
    email_changeset = change_email(email_change)

    with {:ok, data} <- apply_action(email_changeset, :submit),
         {:ok, applied_user} <-
           Accounts.apply_user_email(socket.assigns.current_user, data.current_password, %{
             email: data.email
           }),
         {:ok, _} <-
           Accounts.deliver_update_email_instructions(
             applied_user,
             socket.assigns.current_user.email,
             &Routes.user_settings_url(socket, :confirm_email, &1)
           ) do
      {:noreply,
       socket
       |> put_flash(:info, "Byl vám zaslán email s instrukcemi")
       |> assign(:email_changeset, email_changeset)}
    else
      {:error, changeset} ->
        {:noreply, socket |> assign(:email_changeset, changeset)}
    end
  end

  defp change_email(params) do
    types = %{email: :string, current_password: :string}

    {%{}, types}
    |> cast(params, Map.keys(types))
    |> validate_required([:email, :current_password])
  end

  defp change_password(params) do
    types = %{new_password1: :string, new_password2: :string, current_password: :string}

    {%{}, types}
    |> cast(params, Map.keys(types))
    |> validate_required([:new_password1, :new_password2, :current_password])
  end
end
