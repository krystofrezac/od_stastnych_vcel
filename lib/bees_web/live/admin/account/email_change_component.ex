defmodule BeesWeb.Admin.Live.Account.EmailChangeComponent do
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
      |> assign(:email_changeset, change_email(%{}))
    }
  end

  @impl Phoenix.LiveComponent
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
    }
  end

  @impl Phoenix.LiveComponent
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

  @impl Phoenix.LiveComponent
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
       |> assign(:email_changeset, email_changeset)
       |> push_patch(to: socket.assigns.url)}
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
end
