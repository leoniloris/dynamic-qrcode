defmodule DynQrcodeWeb.QrCodeController do
  use DynQrcodeWeb, :controller

  alias DynQrcode.QrCodes
  alias DynQrcode.QrCodes.QrCode

  def index(conn, _params) do
    IO.puts("INDEX INDEX INDEX INDEX INDEX")
    qrcode = QrCodes.list_qrcode()
    render(conn, "index.html", qrcode: qrcode)
  end

  def new(conn, _params) do
    IO.puts("NEW NEW NEW NEW NEW")
    changeset = QrCodes.change_qr_code(%QrCode{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"qr_code" => qr_code_params}) do
    IO.puts("CREATE CREATE CREATE CREATE CREATE")

    case QrCodes.create_qr_code(qr_code_params) do
      {:ok, qr_code} ->
        conn
        |> put_flash(:info, "Qr code created successfully.")
        |> redirect(to: Routes.qr_code_path(conn, :show, qr_code))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def fetch(conn, %{"base_url" => base_url}) do
    qr_code = QrCodes.get_all_qr_codes_with_base_url!(base_url)
    |> Enum.filter(fn q -> q.is_valid end)
    |> Enum.at(0, :none)
    conn
    |> Plug.Conn.resp(:found, "")
    |> Plug.Conn.put_resp_header("location", qr_code.target_url)
  end

  def show(conn, %{"id" => id}) do
    IO.puts("SHOW SHOW SHOW SHOW SHOW")
    qr_code = QrCodes.get_qr_code!(id)
    render(conn, "show.html", qr_code: qr_code)
  end

  def edit(conn, %{"id" => id}) do
    IO.puts("EDIT EDIT EDIT EDIT EDIT")
    qr_code = QrCodes.get_qr_code!(id)
    changeset = QrCodes.change_qr_code(qr_code)
    render(conn, "edit.html", qr_code: qr_code, changeset: changeset)
  end

  def update(conn, %{"id" => id, "qr_code" => qr_code_params}) do
    IO.puts("UPDATE UPDATE UPDATE UPDATE UPDATE")
    qr_code = QrCodes.get_qr_code!(id)

    case QrCodes.update_qr_code(qr_code, qr_code_params) do
      {:ok, qr_code} ->
        conn
        |> put_flash(:info, "Qr code updated successfully.")
        |> redirect(to: Routes.qr_code_path(conn, :show, qr_code))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", qr_code: qr_code, changeset: changeset)
        end
      end

  def delete(conn, %{"id" => id}) do
    IO.puts("DELETE DELETE DELETE DELETE DELETE")
    qr_code = QrCodes.get_qr_code!(id)
    {:ok, _qr_code} = QrCodes.delete_qr_code(qr_code)

    conn
    |> put_flash(:info, "Qr code deleted successfully.")
    |> redirect(to: Routes.qr_code_path(conn, :index))
  end
end
