defmodule DynQrcode.QrCodesTest do
  use DynQrcode.DataCase

  alias DynQrcode.QrCodes

  describe "qrcode" do
    alias DynQrcode.QrCodes.QrCode

    @valid_attrs %{base_url: "some base_url", is_valid: true, target_url: "https://www.google.com"}
    @update_attrs %{base_url: "some updated base_url", is_valid: false, target_url: "https://www.twitter.com"}
    @invalid_attrs %{base_url: nil, is_valid: nil, target_url: nil}

    def qr_code_fixture(attrs \\ %{}) do
      {:ok, qr_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QrCodes.create_qr_code()

      qr_code
    end

    test "list_qrcode/0 returns all qrcode" do
      qr_code = qr_code_fixture()
      assert QrCodes.list_qrcode() == [qr_code]
    end

    test "get_qr_code!/1 returns the qr_code with given id" do
      qr_code = qr_code_fixture()
      IO.inspect(qr_code)
      IO.inspect(QrCodes.get_qr_code!(qr_code.id))
      assert QrCodes.get_qr_code!(qr_code.id) == qr_code
    end

    test "create_qr_code/1 with valid data creates a qr_code" do
      assert {:ok, %QrCode{} = qr_code} = QrCodes.create_qr_code(@valid_attrs)
      assert qr_code.base_url == "some base_url"
      assert qr_code.is_valid == true
      assert qr_code.target_url == "https://www.google.com"
    end

    test "create_qr_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QrCodes.create_qr_code(@invalid_attrs)
    end

    test "update_qr_code/2 with valid data updates the qr_code" do
      qr_code = qr_code_fixture()
      assert {:ok, %QrCode{} = qr_code} = QrCodes.update_qr_code(qr_code, @update_attrs)
      assert qr_code.base_url == "some updated base_url"
      assert qr_code.is_valid == false
      assert qr_code.target_url == "https://www.twitter.com"
    end

    test "update_qr_code/2 with invalid data returns error changeset" do
      qr_code = qr_code_fixture()
      assert {:error, %Ecto.Changeset{}} = QrCodes.update_qr_code(qr_code, @invalid_attrs)
      assert qr_code == QrCodes.get_qr_code!(qr_code.id)
    end

    test "delete_qr_code/1 deletes the qr_code" do
      qr_code = qr_code_fixture()
      assert {:ok, %QrCode{}} = QrCodes.delete_qr_code(qr_code)
      assert_raise Ecto.NoResultsError, fn -> QrCodes.get_qr_code!(qr_code.id) end
    end

    test "change_qr_code/1 returns a qr_code changeset" do
      qr_code = qr_code_fixture()
      assert %Ecto.Changeset{} = QrCodes.change_qr_code(qr_code)
    end
  end
end
