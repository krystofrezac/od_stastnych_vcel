defmodule Bees.Accounts.UserNotifier do
  @moduledoc false

  import Swoosh.Email

  alias Bees.Accounts.User
  alias Bees.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, template, data) do
    email =
      new()
      |> to(recipient)
      |> from({"Od šťastných včel", "krystofrezac@gmail.com"})
      |> put_provider_option(:dynamic_template_data, data)
      |> put_provider_option(:template_id, template)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  @spec deliver_reset_password_instructions(User.t(), String.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, Mailer.get_template(:reset_password), %{url: url})
  end

  @doc """
  Deliver instructions to update a user email.
  """
  @spec deliver_update_email_instructions(User.t(), String.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, Mailer.get_template(:update_email), %{url: url})
  end

  @doc """
  Deliver instructions for first login
  """
  @spec deliver_registration_instructions(User.t(), String.t(), User.t()) ::
          {:ok, String.t()} | {:error, any()}
  def deliver_registration_instructions(user, password, url) do
    deliver(user.email, Mailer.get_template(:registration), %{
      url: url,
      email: user.email,
      password: password
    })
  end
end
