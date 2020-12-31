defmodule LpcManagerWeb.MainController do
  use LpcManagerWeb, :controller

  def index(conn, _param) do
    render(conn, "index.html")
  end
end
