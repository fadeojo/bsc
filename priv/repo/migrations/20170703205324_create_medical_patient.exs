defmodule Bsc.Repo.Migrations.CreateBsc.Medical.Patient do
  use Ecto.Migration

  def change do
    create table(:medical_patients) do
      add :first_name, :string
      add :last_name, :string
      add :sex, :string
      add :height, :string
      add :org_id, references(:medical_orgs, on_delete: :nothing)
      add :user_id, references(:medical_users, on_delete: :nothing)
      add :room_id, references(:medical_rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:medical_patients, [:org_id])
    create index(:medical_patients, [:user_id])
    create index(:medical_patients, [:room_id])
  end
end
