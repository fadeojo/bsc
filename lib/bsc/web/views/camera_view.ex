defmodule Bsc.Web.CameraView do
  @moduledoc """
  auth JSON reponse views
  """
  use Bsc.Web, :view
  alias Bsc.Web.CameraView

  def render("index.json", %{camera: bio_data_list}) do
    %{data: render_many(bio_data_list, CameraView, "camera_data_list.json")}
  end

  def render("camera_data_list.json", bio_data) do
    case bio_data do
      %{
        posture: posture,
        timestamp: timestamp
      } ->
        %{
          posture: posture,
          timestamp: timestamp
        }

      _ ->
        %{
          posture: "",
          timestamp: ""
        }
    end
  end

  def render("camera.json", %{
        posture: posture,
        timestamp: timestamp
      }) do
    %{
      posture: posture,
      timestamp: timestamp
    }
  end
end