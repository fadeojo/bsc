defmodule Bsc.Medical.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bsc.Medical.User


  schema "medical_users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :reset_token, :string
    field :role, :string
    field :username, :string
    field :org_id, :id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username, :email, :password_hash, :reset_token, :role])
    |> validate_required([:first_name, :last_name, :username, :email, :password_hash, :reset_token, :role])
  end
end
