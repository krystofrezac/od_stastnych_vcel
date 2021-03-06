defmodule BeesWeb.Admin.UserSessionController do
  use BeesWeb, [:controller, :admin]

  alias Bees.Accounts
  alias BeesWeb.UserAuth

  @spec new(Plug.Conn.t(), %{}) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  @spec create(Plug.Conn.t(), %{user: %{email: String.t(), password: String.t()}}) ::
          Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      render(conn, "new.html", error_message: "Nesprávný email nebo heslo")
    end
  end

  @spec delete(Plug.Conn.t(), %{}) :: Plug.Conn.t()
  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Odhlášení proběhlo úspěšně")
    |> UserAuth.log_out_user()
  end
end
