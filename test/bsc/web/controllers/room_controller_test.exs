defmodule Bsc.Web.RoomControllerTest do
  use Bsc.Web.ConnCase

  alias Bsc.Medical
  alias Bsc.Medical.Room

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:room) do
    {:ok, room} = Medical.create_room(@create_attrs)
    room
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, room_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates room and renders room when data is valid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), room: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, room_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "name" => "some name"}
  end

  test "does not create room and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), room: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen room and renders room when data is valid", %{conn: conn} do
    %Room{id: id} = room = fixture(:room)
    conn = put conn, room_path(conn, :update, room), room: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, room_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "name" => "some updated name"}
  end

  test "does not update chosen room and renders errors when data is invalid", %{conn: conn} do
    room = fixture(:room)
    conn = put conn, room_path(conn, :update, room), room: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen room", %{conn: conn} do
    room = fixture(:room)
    conn = delete conn, room_path(conn, :delete, room)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, room_path(conn, :show, room)
    end
  end
end
