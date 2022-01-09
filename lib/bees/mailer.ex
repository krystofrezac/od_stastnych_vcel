defmodule Bees.Mailer do
  @moduledoc false

  use Swoosh.Mailer, otp_app: :bees

  @spec get_template(atom()) :: String.t()
  def get_template(name) do
    Application.get_env(:bees, Bees.Mailer)
    |> Keyword.get(:templates, %{})
    |> Map.get(name, "not found")
  end
end
