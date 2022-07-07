defmodule Govern.Repo.Migrations.CreatePantries do
  use Ecto.Migration

  def change do
    create table(:pantries) do
      add :name, :string
      add :address, :string
      add :description, :string
      add :photo, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:pantries, [:user_id])
  end
end
