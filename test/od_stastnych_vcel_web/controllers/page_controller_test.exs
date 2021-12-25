defmodule OdStastnychVcelWeb.PageControllerTest do
  use OdStastnychVcelWeb.ConnCase

  test "GET /", %{conn: conn} do
    get(conn, "/")
  end
end
