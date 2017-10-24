defmodule Bsc.Web.DeviceController do
  use Bsc.Web, :controller
  require IEx

  alias Bsc.Medical

  action_fallback Bsc.Web.FallbackController

  def index(conn, params) do
    bio_data_list =  Mongo.find(:bsc, "radar", %{}, limit: 300) |> Enum.to_list
    conn |> render("index.json", %{radar: bio_data_list})
  end

  def search(conn, params) do
    bio_data_list =  Mongo.find(:bsc, "radar", params["query"], limit: 300) |> Enum.to_list
    conn |> render("index.json", %{radar: bio_data_list})
  end

  def create(conn, %{"device" => device_params}) do
    Mongo.insert_one(:bsc, "radar", %{radar_tick: device_params})
    Bsc.Web.Endpoint.broadcast! "room:#{device_params["deviceId"]}", "shout", %{brate: device_params["BreathingRate"]}
    conn |> render("radar.json", %{brate: device_params["BreathingRate"]})
  end

end