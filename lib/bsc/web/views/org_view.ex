defmodule Bsc.Web.OrgView do
  use Bsc.Web, :view
  alias Bsc.Web.OrgView

  def render("index.json", %{orgs: orgs}) do
    %{data: render_many(orgs, OrgView, "org.json")}
  end

  def render("show.json", %{org: org}) do
    %{data: render_one(org, OrgView, "org.json")}
  end

  def render("org.json", %{org: org}) do
    %{id: org.id,
      name: org.name}
  end
end
