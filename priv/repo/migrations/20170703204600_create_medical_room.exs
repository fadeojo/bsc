defmodule Bsc.Repo.Migrations.CreateBsc.Medical.Room do
  use Ecto.Migration

  def change do
    create table(:medical_rooms) do
      add :name, :string
      add :description, :string
      add :org_id, references(:medical_orgs, on_delete: :nothing)

      timestamps()
    end

    create index(:medical_rooms, [:org_id])
  end
end
