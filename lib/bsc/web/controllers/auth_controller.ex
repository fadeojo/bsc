defmodule Bsc.Web.AuthController do
  use Bsc.Web, :controller

  alias Bsc.Medical

  action_fallback Bsc.Web.FallbackController

  def login(conn, %{"user" => user_params}) do
    case Bsc.Medical.check_pswd(user_params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires",  "#{exp}")
        |> render("login.json", %{token: jwt})
    end
  end
end