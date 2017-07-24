defmodule Bsc.Web.DeviceView do
  @moduledoc """
  auth JSON reponse views
  """
  use Bsc.Web, :view

  def render("radar.json", %{brate: rate}) do
    %{brate: rate}
  end
end