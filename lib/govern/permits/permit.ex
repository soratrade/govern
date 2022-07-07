defmodule Govern.Permits.Permit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permits" do
    field :name, :string
    field :photo, :string
    field :status, :string
    field :step, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(permit, attrs) do
    permit
    |> cast(attrs, [:photo, :name, :status, :step])
    |> validate_required([:name])
  end
end
