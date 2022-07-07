defmodule Govern.News.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :category, :string
    field :content, :string
    field :intro, :string
    field :name, :string
    field :photo, :string
    field :subname, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:category, :name, :subname, :intro, :content, :photo, :user_id])
    |> validate_required([:name, :content])
  end
end
