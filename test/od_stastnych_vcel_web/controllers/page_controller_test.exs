defmodule BeesWeb.PageControllerTest do
  use BeesWeb.ConnCase

  test "GET /", %{conn: conn} do
    get(conn, "/")
  end
end
