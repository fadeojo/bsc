defmodule Bsc.Web.DeviceController do
  use Bsc.Web, :controller

  alias Bsc.Medical

  action_fallback Bsc.Web.FallbackController

  def create(conn, %{"device" => devicce_params}) do

  end
end