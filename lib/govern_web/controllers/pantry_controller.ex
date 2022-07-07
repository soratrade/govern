defmodule GovernWeb.PantryController do
  use GovernWeb, :controller

  alias Govern.Pantries
  alias Govern.Pantries.Pantry

  def index(conn, _params) do
    pantries = Pantries.list_pantries()
    render(conn, "index.html", pantries: pantries)
  end

  def new(conn, _params) do
    changeset = Pantries.change_pantry(%Pantry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pantry" => pantry_params}) do
    case Pantries.create_pantry(pantry_params) do
      {:ok, pantry} ->
        conn
        |> put_flash(:info, "Pantry created successfully.")
        |> redirect(to: Routes.pantry_path(conn, :show, pantry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pantry = Pantries.get_pantry!(id)
    render(conn, "show.html", pantry: pantry)
  end

  def edit(conn, %{"id" => id}) do
    pantry = Pantries.get_pantry!(id)
    changeset = Pantries.change_pantry(pantry)
    render(conn, "edit.html", pantry: pantry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pantry" => pantry_params}) do
    pantry = Pantries.get_pantry!(id)

    case Pantries.update_pantry(pantry, pantry_params) do
      {:ok, pantry} ->
        conn
        |> put_flash(:info, "Pantry updated successfully.")
        |> redirect(to: Routes.pantry_path(conn, :show, pantry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pantry: pantry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pantry = Pantries.get_pantry!(id)
    {:ok, _pantry} = Pantries.delete_pantry(pantry)

    conn
    |> put_flash(:info, "Pantry deleted successfully.")
    |> redirect(to: Routes.pantry_path(conn, :index))
  end
end
