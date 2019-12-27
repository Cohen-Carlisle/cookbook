defmodule CookbookWeb.AccountControllerTest do
  use CookbookWeb.ConnCase
  alias Cookbook.Account
  alias Cookbook.Repo

  describe "GET /login" do
    test "while unauthenticated, renders a login page", %{conn: conn} do
      resp_conn = get(conn, "/login")
      assert html_response(resp_conn, 200) =~ "Login"
    end

    test "while already logged in, redirects to order creation", %{conn: conn} do
      resp_conn =
        conn
        |> assign(:user, %{id: 1, username: "test user"})
        |> get("/login")

      assert html_response(resp_conn, 302)
      assert get_resp_header(resp_conn, "location") == ["/meals"]
    end
  end

  describe "POST /login" do
    setup do
      %Account.User{}
      |> Account.User.changeset(%{username: "some user"})
      |> Repo.insert!()

      :ok
    end

    test "with valid credentials, logs in the user", %{conn: conn} do
      resp_conn = post(conn, "/login", %{username: "some user"})
      assert html_response(resp_conn, 302)
      assert %{id: _, username: "some user"} = get_session(resp_conn, :user)
      assert get_resp_header(resp_conn, "location") == ["/meals"]
    end

    test "with invalid credentials, returns to login page", %{conn: conn} do
      resp_conn = post(conn, "/login", %{username: "not a user"})
      assert html_response(resp_conn, 302)
      assert get_session(resp_conn, :user) == nil
      assert get_resp_header(resp_conn, "location") == ["/login"]
    end
  end

  test "GET /logout redirects to login", %{conn: conn} do
    resp_conn =
      conn
      |> authenticate()
      |> get("/logout")

    assert html_response(resp_conn, 302)
    assert get_session(resp_conn, :user) == nil
    assert get_resp_header(resp_conn, "location") == ["/login"]
  end

  defp authenticate(conn) do
    %Account.User{}
    |> Account.User.changeset(%{username: "auth user"})
    |> Repo.insert!()

    session =
      conn
      |> post("/login", %{username: "auth user"})
      |> get_resp_header("set-cookie")
      |> List.first()
      |> (&Regex.run(~r{_cookbook_key=[^;]+}, &1)).()
      |> List.first()

    put_req_header(conn, "cookie", session)
  end
end
