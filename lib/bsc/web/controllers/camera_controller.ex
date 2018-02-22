defmodule Bsc.Web.CameraController do
  use Bsc.Web, :controller
  require IEx

  alias Bsc.Medical

  action_fallback(Bsc.Web.FallbackController)

  def create(conn, device_params) do
    Mongo.insert_one(:bsc, "camera", %{camera_tick: device_params})

    bio_data = %{
      posture: device_params["posture"] || "",
      timestamp: device_params["timestamp"] || ""
    }

    Bsc.Web.Endpoint.broadcast!("room:posture", "shout", bio_data)

    conn
    |> render("camera.json", %{
      posture: device_params["posture"] || "",
      timestamp: device_params["timestamp"] || ""
    })
  end
end