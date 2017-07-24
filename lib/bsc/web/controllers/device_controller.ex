defmodule Bsc.Web.DeviceController do
  use Bsc.Web, :controller

  alias Bsc.Medical

  action_fallback Bsc.Web.FallbackController

  def create(conn, %{"device" => device_params}) do
    Mongo.insert_one(:bsc, "radar", %{brate: device_params["brate"]})
    Bsc.Web.Endpoint.broadcast! "room:123", "new_msg", %{brate: device_params["brate"]}
    conn |> render("radar.json", %{brate: device_params["brate"]})
  end
end