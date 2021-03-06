defmodule Bsc.Web.UserControllerTest do
  use Bsc.Web.ConnCase

  alias Bsc.Medical
  alias Bsc.Medical.User

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", password_hash: "some password_hash", reset_token: "some reset_token", role: "some role", username: "some username"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password_hash: "some updated password_hash", reset_token: "some updated reset_token", role: "some updated role", username: "some updated username"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, reset_token: nil, role: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Medical.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates user and renders user when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some email",
      "first_name" => "some first_name",
      "last_name" => "some last_name",
      "password_hash" => "some password_hash",
      "reset_token" => "some reset_token",
      "role" => "some role",
      "username" => "some username"}
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen user and renders user when data is valid", %{conn: conn} do
    %User{id: id} = user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some updated email",
      "first_name" => "some updated first_name",
      "last_name" => "some updated last_name",
      "password_hash" => "some updated password_hash",
      "reset_token" => "some updated reset_token",
      "role" => "some updated role",
      "username" => "some updated username"}
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, user)
    end
  end
end
