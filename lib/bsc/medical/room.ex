defmodule Bsc.Medical.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bsc.Medical.Room


  schema "medical_rooms" do
    field :description, :string
    field :name, :string
    field :org_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
