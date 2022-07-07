defmodule Govern.Pantries.Pantry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pantries" do
    field :address, :string
    field :description, :string
    field :name, :string
    field :photo, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(pantry, attrs) do
    pantry
    |> cast(attrs, [:name, :address, :description, :photo])
    |> validate_required([:name])
  end
end
