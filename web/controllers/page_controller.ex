defmodule Wicket.PageController do
  use Wicket.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
