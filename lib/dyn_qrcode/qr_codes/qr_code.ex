defmodule DynQrcode.QrCodes.QrCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "qrcode" do
    field :base_url, :string
    field :is_valid, :boolean, default: true
    field :target_url, :string

    timestamps()
  end

  @doc false
  def changeset(qr_code, attrs) do
    qr_code
    |> cast(attrs, [:base_url, :target_url, :is_valid])
    |> validate_required([:base_url, :target_url, :is_valid])
  end
end
