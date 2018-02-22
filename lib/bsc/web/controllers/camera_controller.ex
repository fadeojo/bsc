defmodule Bsc.Web.CameraController do
  use Bsc.Web, :controller
  require IEx

  alias Bsc.Medical

  action_fallback(Bsc.Web.FallbackController)

  def create(conn, device_params) do
    bio_data = %{
      posture: device_params["posture"] || "",
      timestamp: device_params["timestamp"] || ""
    }

    Mongo.insert_one(:bsc, "camera", %{camera_tick: bio_data})

    Bsc.Web.Endpoint.broadcast!("room:posture", "shout", bio_data)

    conn
    |> render("camera.json", %{
      posture: device_params["posture"] || "",
      timestamp: device_params["timestamp"] || ""
    })
  end
end