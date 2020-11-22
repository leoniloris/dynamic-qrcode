defmodule DynQrcode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DynQrcode.Repo,
      # Start the Telemetry supervisor
      DynQrcodeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DynQrcode.PubSub},
      # Start the Endpoint (http/https)
      DynQrcodeWeb.Endpoint,
      # Start a worker by calling: DynQrcode.Worker.start_link(arg)
      # {DynQrcode.Worker, arg}
      %{
        id: DynQrcode.UrlContentValidator,
        start: { DynQrcode.UrlContentValidator, :start_link, [] }
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DynQrcode.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DynQrcodeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
