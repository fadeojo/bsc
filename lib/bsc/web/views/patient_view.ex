defmodule Bsc.Web.PatientView do
  use Bsc.Web, :view
  alias Bsc.Web.PatientView

  def render("index.json", %{patients: patients}) do
    %{data: render_many(patients, PatientView, "patient.json")}
  end

  def render("show.json", %{patient: patient}) do
    %{data: render_one(patient, PatientView, "patient.json")}
  end

  def render("patient.json", %{patient: patient}) do
    %{id: patient.id,
      first_name: patient.first_name,
      last_name: patient.last_name,
      sex: patient.sex,
      room: patient.room_id,
      height: patient.height}
  end
end
