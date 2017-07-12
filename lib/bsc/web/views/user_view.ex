defmodule Bsc.Web.UserView do
  use Bsc.Web, :view
  alias Bsc.Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      username: user.username,
      email: user.email,
      reset_token: user.reset_token,
      role: user.role}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
