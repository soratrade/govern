defmodule GovernWeb.PageController do
  use GovernWeb, :controller

  def bus(conn, _params) do
    render(conn, "bus.html")
  end

  def jeep(conn, _params) do
    render(conn, "jeep.html")
  end

  def tricycle(conn, _params) do
    render(conn, "tricycle.html")
  end

end
