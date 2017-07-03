defmodule Bsc.Web.PatientController do
  use Bsc.Web, :controller

  alias Bsc.Medical
  alias Bsc.Medical.Patient

  action_fallback Bsc.Web.FallbackController

  def index(conn, _params) do
    patients = Medical.list_patients()
    render(conn, "index.json", patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    with {:ok, %Patient{} = patient} <- Medical.create_patient(patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", patient_path(conn, :show, patient))
      |> render("show.json", patient: patient)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Medical.get_patient!(id)
    render(conn, "show.json", patient: patient)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Medical.get_patient!(id)

    with {:ok, %Patient{} = patient} <- Medical.update_patient(patient, patient_params) do
      render(conn, "show.json", patient: patient)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Medical.get_patient!(id)
    with {:ok, %Patient{}} <- Medical.delete_patient(patient) do
      send_resp(conn, :no_content, "")
    end
  end
end
