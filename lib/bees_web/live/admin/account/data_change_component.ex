defmodule BeesWeb.Admin.Live.Account.DataChangeComponent do
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
    }
  end

  @impl Phoenix.LiveComponent
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:changeset, normalize_data(assigns.current_user))
    }
  end

  @impl Phoenix.LiveComponent
  def handle_event("change", %{"data_change" => data_change}, socket) do
    changeset =
      normalize_data(socket.assigns.current_user, data_change)
      |> Map.put(:action, :change)

    {
      :noreply,
      socket
      |> assign(:changeset, changeset)
    }
  end

  @impl Phoenix.LiveComponent
  def handle_event("submit", %{"data_change" => data_change}, socket) do
    with {:ok, _data} <-
           normalize_data(socket.assigns.current_user, data_change)
           |> apply_action(:submit),
         {:ok, _updated_user} <-
           Accounts.update_user(socket.assigns.current_user, data_change) do
      {
        :noreply,
        socket
        |> put_flash(:info, "Údaje úspěšně změněny")
        # needs to be redirect so current_user is updated
        |> push_redirect(to: socket.assigns.url)
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

  defp normalize_data(data, params \\ %{}) do
    types = %{name: :string}

    {data, types}
    |> cast(params, Map.keys(types))
    |> validate_required([:name])
  end
end
