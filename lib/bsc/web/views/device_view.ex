defmodule Bsc.Web.DeviceView do
  @moduledoc """
  auth JSON reponse views
  """
  use Bsc.Web, :view
  alias Bsc.Web.DeviceView

  def render("index.json", %{radar: bio_data_list}) do
    %{data: render_many(bio_data_list, DeviceView, "bio_data_list.json")}
  end

  def render("bio_data_list.json", bio_data) do
    case bio_data do
      %{device: %{"radar_tick" => %{"BreathingRate" => rate} }} ->
        %{breathing_rate: rate }
      _ ->
        %{breathing_rate: 0 }

    end

  end

  def render("radar.json", %{brate: rate}) do
    %{brate: rate}
  end
end