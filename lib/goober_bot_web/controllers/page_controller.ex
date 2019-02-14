defmodule GooberBotWeb.PageController do
  use GooberBotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
