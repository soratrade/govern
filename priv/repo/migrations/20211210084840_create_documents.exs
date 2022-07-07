defmodule Govern.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :name, :string
      add :link, :string
      add :description, :string
      add :views, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:documents, [:user_id])
  end
end
