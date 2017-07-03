defmodule Bsc.Web.PatientControllerTest do
  use Bsc.Web.ConnCase

  alias Bsc.Medical
  alias Bsc.Medical.Patient

  @create_attrs %{first_name: "some first_name", height: "some height", last_name: "some last_name", sex: "some sex"}
  @update_attrs %{first_name: "some updated first_name", height: "some updated height", last_name: "some updated last_name", sex: "some updated sex"}
  @invalid_attrs %{first_name: nil, height: nil, last_name: nil, sex: nil}

  def fixture(:patient) do
    {:ok, patient} = Medical.create_patient(@create_attrs)
    patient
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, patient_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates patient and renders patient when data is valid", %{conn: conn} do
    conn = post conn, patient_path(conn, :create), patient: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, patient_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "first_name" => "some first_name",
      "height" => "some height",
      "last_name" => "some last_name",
      "sex" => "some sex"}
  end

  test "does not create patient and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, patient_path(conn, :create), patient: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen patient and renders patient when data is valid", %{conn: conn} do
    %Patient{id: id} = patient = fixture(:patient)
    conn = put conn, patient_path(conn, :update, patient), patient: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, patient_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "first_name" => "some updated first_name",
      "height" => "some updated height",
      "last_name" => "some updated last_name",
      "sex" => "some updated sex"}
  end

  test "does not update chosen patient and renders errors when data is invalid", %{conn: conn} do
    patient = fixture(:patient)
    conn = put conn, patient_path(conn, :update, patient), patient: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen patient", %{conn: conn} do
    patient = fixture(:patient)
    conn = delete conn, patient_path(conn, :delete, patient)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, patient_path(conn, :show, patient)
    end
  end
end
