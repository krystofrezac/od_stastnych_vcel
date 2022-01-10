defmodule BeesWeb.Admin.UserSettingsController do
  use BeesWeb, [:controller, :admin]

  alias Bees.Accounts

  @spec confirm_email(Plug.Conn.t(), %{token: String.t()}) :: Plug.Conn.t()
  def confirm_email(conn, %{"token" => token}) do
    case Accounts.update_user_email(conn.assigns.current_user, token) do
      :ok ->
        conn
        |> put_flash(:info, "Email úspěšně změnen")
        |> redirect(to: Routes.admin_dashboard_index_path(conn, :index))

      :error ->
        conn
        |> put_flash(:error, "Odkaz je neplatný nebo vypršela jeho platnost.")
        |> redirect(to: Routes.admin_dashboard_index_path(conn, :index))
    end
  end
end
