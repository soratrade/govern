defmodule GovernWeb.DocumentController do
  use GovernWeb, :controller

  alias Govern.Docs
  alias Govern.Docs.Document

  def index(conn, _params) do
    documents = Docs.list_documents()
    render(conn, "index.html", documents: documents)
  end

  def new(conn, _params) do
    changeset = Docs.change_document(%Document{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"document" => document_params}) do
    case Docs.create_document(document_params) do
      {:ok, document} ->
        conn
        |> put_flash(:info, "Document created successfully.")
        |> redirect(to: Routes.document_path(conn, :show, document))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    document = Docs.get_document!(id)
    render(conn, "show.html", document: document)
  end

  def edit(conn, %{"id" => id}) do
    document = Docs.get_document!(id)
    changeset = Docs.change_document(document)
    render(conn, "edit.html", document: document, changeset: changeset)
  end

  def update(conn, %{"id" => id, "document" => document_params}) do
    document = Docs.get_document!(id)

    case Docs.update_document(document, document_params) do
      {:ok, document} ->
        conn
        |> put_flash(:info, "Document updated successfully.")
        |> redirect(to: Routes.document_path(conn, :show, document))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", document: document, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    document = Docs.get_document!(id)
    {:ok, _document} = Docs.delete_document(document)

    conn
    |> put_flash(:info, "Document deleted successfully.")
    |> redirect(to: Routes.document_path(conn, :index))
  end
end
