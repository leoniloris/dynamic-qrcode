defmodule DynQrcodeWeb.QrCodeControllerTest do
  use DynQrcodeWeb.ConnCase

  alias DynQrcode.QrCodes

  @create_attrs %{base_url: "some base_url", is_valid: true, target_url: "some target_url"}
  @update_attrs %{base_url: "some updated base_url", is_valid: false, target_url: "some updated target_url"}
  @invalid_attrs %{base_url: nil, is_valid: nil, target_url: nil}

  def fixture(:qr_code) do
    {:ok, qr_code} = QrCodes.create_qr_code(@create_attrs)
    qr_code
  end

  describe "index" do
    test "lists all qrcode", %{conn: conn} do
      conn = get(conn, Routes.qr_code_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Qrcode"
    end
  end

  describe "new qr_code" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.qr_code_path(conn, :new))
      assert html_response(conn, 200) =~ "New Qr code"
    end
  end

  describe "create qr_code" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.qr_code_path(conn, :create), qr_code: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.qr_code_path(conn, :show, id)

      conn = get(conn, Routes.qr_code_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Qr code"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.qr_code_path(conn, :create), qr_code: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Qr code"
    end
  end

  describe "edit qr_code" do
    setup [:create_qr_code]

    test "renders form for editing chosen qr_code", %{conn: conn, qr_code: qr_code} do
      conn = get(conn, Routes.qr_code_path(conn, :edit, qr_code))
      assert html_response(conn, 200) =~ "Edit Qr code"
    end
  end

  describe "update qr_code" do
    setup [:create_qr_code]

    test "redirects when data is valid", %{conn: conn, qr_code: qr_code} do
      conn = put(conn, Routes.qr_code_path(conn, :update, qr_code), qr_code: @update_attrs)
      assert redirected_to(conn) == Routes.qr_code_path(conn, :show, qr_code)

      conn = get(conn, Routes.qr_code_path(conn, :show, qr_code))
      assert html_response(conn, 200) =~ "some updated base_url"
    end

    test "renders errors when data is invalid", %{conn: conn, qr_code: qr_code} do
      conn = put(conn, Routes.qr_code_path(conn, :update, qr_code), qr_code: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Qr code"
    end
  end

  describe "delete qr_code" do
    setup [:create_qr_code]

    test "deletes chosen qr_code", %{conn: conn, qr_code: qr_code} do
      conn = delete(conn, Routes.qr_code_path(conn, :delete, qr_code))
      assert redirected_to(conn) == Routes.qr_code_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.qr_code_path(conn, :show, qr_code))
      end
    end
  end

  defp create_qr_code(_) do
    qr_code = fixture(:qr_code)
    %{qr_code: qr_code}
  end
end
