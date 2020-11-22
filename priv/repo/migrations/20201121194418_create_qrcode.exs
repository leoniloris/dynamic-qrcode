defmodule DynQrcode.Repo.Migrations.CreateQrcode do
  use Ecto.Migration

  def change do
    create table(:qrcode) do
      add :base_url, :string
      add :target_url, :string
      add :is_valid, :boolean, default: true, null: false

      timestamps()
    end
  end
end
