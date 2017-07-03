defmodule Bsc.Repo.Migrations.CreateBsc.Medical.Org do
  use Ecto.Migration

  def change do
    create table(:medical_orgs) do
      add :name, :string

      timestamps()
    end

  end
end
