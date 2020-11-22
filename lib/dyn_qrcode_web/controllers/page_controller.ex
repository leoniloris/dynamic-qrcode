defmodule DynQrcodeWeb.PageController do
  use DynQrcodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
