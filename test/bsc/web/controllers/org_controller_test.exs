defmodule Bsc.Web.OrgControllerTest do
  use Bsc.Web.ConnCase

  alias Bsc.Medical
  alias Bsc.Medical.Org

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:org) do
    {:ok, org} = Medical.create_org(@create_attrs)
    org
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, org_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates org and renders org when data is valid", %{conn: conn} do
    conn = post conn, org_path(conn, :create), org: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, org_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create org and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, org_path(conn, :create), org: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen org and renders org when data is valid", %{conn: conn} do
    %Org{id: id} = org = fixture(:org)
    conn = put conn, org_path(conn, :update, org), org: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, org_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen org and renders errors when data is invalid", %{conn: conn} do
    org = fixture(:org)
    conn = put conn, org_path(conn, :update, org), org: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen org", %{conn: conn} do
    org = fixture(:org)
    conn = delete conn, org_path(conn, :delete, org)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, org_path(conn, :show, org)
    end
  end
end
