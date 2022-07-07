defmodule Govern.Docs.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :description, :string
    field :link, :string
    field :name, :string
    field :views, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :link, :description, :views, :user_id])
    |> validate_required([:name])
  end
end
