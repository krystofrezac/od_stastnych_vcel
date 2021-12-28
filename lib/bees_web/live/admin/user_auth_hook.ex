defmodule BeesWeb.Admin.Live.UserAuthHook do
  @moduledoc """
    Authorization hook for liveview
  """

  alias Phoenix.LiveView

  alias Bees.Accounts
  # credo:disable-for-next-line Credo.Check.Readability.AliasAs
  alias BeesWeb.Router.Helpers, as: Routes

  @spec on_mount(atom(), map(), %{optional(:user_token) => String.t()}, LiveView.Socket) ::
          {:cont, LiveView.Socket} | {:halt, LiveView.Socket}
  def on_mount(_type, _opts, session, socket) do
    user_token = Map.get(session, "user_token")

    with true <- user_token != nil,
         true <- Accounts.get_user_by_session_token(user_token) != nil do
      {:cont, socket}
    else
      _error ->
        {:halt,
         socket
         |> LiveView.put_flash(:error, "Musíte se nejdříve přihlásit")
         |> LiveView.redirect(to: Routes.user_session_path(socket, :new))}
    end
  end
end
