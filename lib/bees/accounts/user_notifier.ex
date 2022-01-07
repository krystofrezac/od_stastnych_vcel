defmodule Bees.Accounts.UserNotifier do
  @moduledoc false

  import Swoosh.Email

  alias Bees.Accounts.User
  alias Bees.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"MyApp", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  @spec deliver_confirmation_instructions(User.t(), String.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_confirmation_instructions(user, url) do
    deliver(user.email, "Confirmation instructions", """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  @spec deliver_reset_password_instructions(User.t(), String.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, "Reset password instructions", """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  @spec deliver_update_email_instructions(User.t(), String.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions for first login
  """
  @spec deliver_registration_instructions(User.t(), String.t(), User.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_registration_instructions(user, password, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Byli jste zaregistrováni do systému Od šťastných včel.
    Pro první přihlášení použijte následující heslo a email.
    heslo: #{password}
    email: #{user.email}
     
    Heslo si můžete po přihlášení změnit.

    Přihlásit se můžete zde: #{url}
    ==============================
    """)
  end
end
