defmodule CookbookWeb.PageControllerTest do
  use CookbookWeb.ConnCase

  test "GET /", %{conn: conn} do
    resp_conn = get(conn, "/")
    assert html_response(resp_conn, 200) =~ "Welcome to Phoenix!"
  end

  test "GET /user/ without authentication", %{conn: conn} do
    resp_conn = get(conn, "/user/")
    assert html_response(resp_conn, 302)
    assert get_resp_header(resp_conn, "location") == ["/login"]
  end

  test "GET /user/ while authenticated", %{conn: conn} do
    resp_conn =
      conn
      |> assign(:user, %{id: 1, username: "test user"})
      |> get("/user/")

    assert html_response(resp_conn, 200) =~ "Welcome to Phoenix!"
  end
end
