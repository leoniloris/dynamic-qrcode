defmodule DynQrcode.Repo do
  use Ecto.Repo,
    otp_app: :dyn_qrcode,
    adapter: Ecto.Adapters.Postgres
end
