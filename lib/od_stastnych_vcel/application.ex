defmodule OdStastnychVcel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OdStastnychVcel.Repo,
      # Start the Telemetry supervisor
      OdStastnychVcelWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OdStastnychVcel.PubSub},
      # Start the Endpoint (http/https)
      OdStastnychVcelWeb.Endpoint
      # Start a worker by calling: OdStastnychVcel.Worker.start_link(arg)
      # {OdStastnychVcel.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OdStastnychVcel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl Application
  def config_change(changed, _new, removed) do
    OdStastnychVcelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
