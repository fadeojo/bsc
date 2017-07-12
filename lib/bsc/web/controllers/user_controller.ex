defmodule Bsc.Web.UserController do
  use Bsc.Web, :controller

  alias Bsc.Medical
  alias Bsc.Medical.User

  action_fallback Bsc.Web.FallbackController
  plug Guardian.Plug.EnsureAuthenticated, [handler: __MODULE__] when not action in [:create]

  def index(conn, _params) do
    users = Medical.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Medical.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Medical.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Medical.get_user!(id)

    with {:ok, %User{} = user} <- Medical.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Medical.get_user!(id)
    with {:ok, %User{}} <- Medical.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render "error.json", message: "Authentication required"
  end
end
