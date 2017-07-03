defmodule Bsc.Repo.Migrations.CreateBsc.Medical.User do
  use Ecto.Migration

  def change do
    create table(:medical_users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :reset_token, :string
      add :role, :string
      add :org_id, references(:medical_orgs, on_delete: :nothing)

      timestamps()
    end

    create index(:medical_users, [:org_id])
    create unique_index(:medical_users, [:email, :username])
  end
end
