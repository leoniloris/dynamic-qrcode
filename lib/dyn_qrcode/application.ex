defmodule DynQrcode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias DynQrcode.DynQrcode.UrlContentValidator

  @url System.get_env("APP_URL") || "localhost:4000"

  def url, do: @url

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
        id: UrlContentValidator,
        start: { UrlContentValidator, :start_link, [] }
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
