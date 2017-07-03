defmodule Bsc.Medical.Org do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bsc.Medical.Org


  schema "medical_orgs" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Org{} = org, attrs) do
    org
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
