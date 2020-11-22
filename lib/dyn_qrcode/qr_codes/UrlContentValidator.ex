defmodule DynQrcode.DynQrcode.UrlContentValidator do
  use GenServer
  alias DynQrcode.QrCodes

  @check_period_ms 2 * 60 * 60 * 1000
  # @check_period_ms 3_000

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    QrCodes.list_qrcode()
    |> Enum.filter(&is_target_url_content_invalid/1)
    |> Enum.each(fn qr_code -> QrCodes.update_qr_code(qr_code, %{is_valid: false}) end)

    schedule_work()
    {:noreply, state}
  end

  defp is_target_url_content_invalid(%{target_url: target_url}) do
    case HTTPoison.get(target_url) do
      {:ok, %HTTPoison.Response{status_code: code, body: _body}} when code in 200..299 ->
        false
      err ->
        IO.puts("Error verifying url")
        IO.inspect(err)
        true
    end
  end

  defp schedule_work() do
    Process.send_after(self(), :work, @check_period_ms)
  end
end
