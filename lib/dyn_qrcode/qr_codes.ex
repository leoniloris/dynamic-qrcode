defmodule DynQrcode.QrCodes do
  @moduledoc """
  The QrCodes context.
  """

  import Ecto.Query, warn: false
  alias DynQrcode.Repo

  alias DynQrcode.QrCodes.QrCode

  @doc """
  Returns the list of qrcode.

  ## Examples

      iex> list_qrcode()
      [%QrCode{}, ...]

  """
  def list_qrcode do
    Repo.all(QrCode)
  end

  @doc """
  Gets a single qr_code.

  Raises `Ecto.NoResultsError` if the Qr code does not exist.

  ## Examples

      iex> get_qr_code!(123)
      %QrCode{}

      iex> get_qr_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_qr_code!(id), do: Repo.get!(QrCode, id)

  def get_all_qr_codes_with_base_url!(base_url), do: Repo.all(from(q in QrCode, where: q.base_url == ^base_url))

  @doc """
  Creates a qr_code.

  ## Examples

      iex> create_qr_code(%{field: value})
      {:ok, %QrCode{}}

      iex> create_qr_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_qr_code(attrs \\ %{}) do
    %QrCode{}
    |> QrCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a qr_code.

  ## Examples

      iex> update_qr_code(qr_code, %{field: new_value})
      {:ok, %QrCode{}}

      iex> update_qr_code(qr_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_qr_code(%QrCode{} = qr_code, attrs) do
    qr_code
    |> QrCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a qr_code.

  ## Examples

      iex> delete_qr_code(qr_code)
      {:ok, %QrCode{}}

      iex> delete_qr_code(qr_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_qr_code(%QrCode{} = qr_code) do
    Repo.delete(qr_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking qr_code changes.

  ## Examples

      iex> change_qr_code(qr_code)
      %Ecto.Changeset{data: %QrCode{}}

  """
  def change_qr_code(%QrCode{} = qr_code, attrs \\ %{}) do
    QrCode.changeset(qr_code, attrs)
  end
end
