defmodule Govern.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema, password_min_length: 4

  import Ecto.Changeset  

  schema "users" do
    pow_user_fields()

    field :name, :string
    field :photo, :string

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:name, :photo])
    |> pow_changeset(attrs)
    |> validate_required([:name, :photo])
  end

end
