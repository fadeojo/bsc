defmodule Bsc.Web.AuthView do
  @moduledoc """
  auth JSON reponse views
  """
  use Bsc.Web, :view

  def render("login.json", %{token: jwt}) do
    %{token: jwt}
  end
end
