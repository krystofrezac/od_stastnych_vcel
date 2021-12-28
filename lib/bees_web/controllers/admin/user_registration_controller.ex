defmodule BeesWeb.Admin.UserRegistrationController do
  use BeesWeb, :controller

  alias Bees.Accounts
  alias Bees.Accounts.User
  alias BeesWeb.UserAuth

  @spec new(Plug.Conn.t(), %{}) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @dialyzer {:no_match, create: 2}
  @spec create(Plug.Conn.t(), %{user: %{email: String.t(), password: String.t()}}) ::
          Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        case Accounts.deliver_user_confirmation_instructions(
               user,
               &Routes.user_confirmation_url(conn, :edit, &1)
             ) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "User created successfully.")
            |> UserAuth.log_in_user(user)

          {:error, _} ->
            render(conn, "new.html")
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
