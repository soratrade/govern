defmodule Govern.Repo.Migrations.CreatePermits do
  use Ecto.Migration

  def change do
    create table(:permits) do
      add :photo, :string
      add :name, :string
      add :status, :string
      add :step, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:permits, [:user_id])
  end
end
