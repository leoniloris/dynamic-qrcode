defmodule DynQrcode.QrCodes.QrCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "qrcode" do
    field(:base_url, :string, default: "")
    field(:is_valid, :boolean, default: true)
    field(:target_url, :string)

    timestamps()
  end

  @doc false
  def changeset(qr_code, attrs) do
    qr_code
    |> cast(attrs, [:base_url, :target_url, :is_valid])
    |> validate_required([:base_url, :target_url, :is_valid])
    |> validate_uri(:target_url)
  end

  def validate_uri(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, url ->
      uri = URI.parse(url)

      case uri do
        %URI{scheme: nil} -> [{field, options[:message] || "URL should be https://something"}]
        %URI{host: nil} -> [{field, options[:message] || "URL should be https://something"}]
        _uri -> []
      end
    end)
  end
end
