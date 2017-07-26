defmodule Bsc.Medical.Patient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bsc.Medical.Patient


  schema "medical_patients" do
    field :first_name, :string
    field :height, :string
    field :last_name, :string
    field :sex, :string
    field :org_id, :id
    field :user_id, :id
    field :room_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Patient{} = patient, attrs) do
    patient
    |> cast(attrs, [:first_name, :last_name, :sex, :height, :org_id, :room_id, :user_id])
    |> validate_required([:first_name, :last_name, :sex, :height])
  end
end
