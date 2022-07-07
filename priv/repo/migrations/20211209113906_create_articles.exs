defmodule Govern.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :category, :string
      add :name, :string
      add :subname, :string
      add :intro, :string
      add :content, :text
      add :photo, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:user_id])
  end
end
