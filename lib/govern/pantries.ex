defmodule Govern.Pantries do
  @moduledoc """
  The Pantries context.
  """

  import Ecto.Query, warn: false
  alias Govern.Repo

  alias Govern.Pantries.Pantry

  @doc """
  Returns the list of pantries.

  ## Examples

      iex> list_pantries()
      [%Pantry{}, ...]

  """
  def list_pantries do
    Repo.all(Pantry)
  end

  @doc """
  Gets a single pantry.

  Raises `Ecto.NoResultsError` if the Pantry does not exist.

  ## Examples

      iex> get_pantry!(123)
      %Pantry{}

      iex> get_pantry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pantry!(id), do: Repo.get!(Pantry, id)

  @doc """
  Creates a pantry.

  ## Examples

      iex> create_pantry(%{field: value})
      {:ok, %Pantry{}}

      iex> create_pantry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pantry(attrs \\ %{}) do
    %Pantry{}
    |> Pantry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pantry.

  ## Examples

      iex> update_pantry(pantry, %{field: new_value})
      {:ok, %Pantry{}}

      iex> update_pantry(pantry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pantry(%Pantry{} = pantry, attrs) do
    pantry
    |> Pantry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pantry.

  ## Examples

      iex> delete_pantry(pantry)
      {:ok, %Pantry{}}

      iex> delete_pantry(pantry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pantry(%Pantry{} = pantry) do
    Repo.delete(pantry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pantry changes.

  ## Examples

      iex> change_pantry(pantry)
      %Ecto.Changeset{data: %Pantry{}}

  """
  def change_pantry(%Pantry{} = pantry, attrs \\ %{}) do
    Pantry.changeset(pantry, attrs)
  end
end
