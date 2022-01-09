defmodule Bees.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bees.Repo,
      # Start the Telemetry supervisor
      BeesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bees.PubSub},
      # Start the Endpoint (http/https)
      BeesWeb.Endpoint
      # Start a worker by calling: Bees.Worker.start_link(arg)
      # {Bees.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bees.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl Application
  def config_change(changed, _new, removed) do
    BeesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
