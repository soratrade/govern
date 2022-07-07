defmodule GovernWeb.PermitLive.FormComponent do
  use GovernWeb, :live_component

  alias Govern.Permits

  @impl true
  def update(%{permit: permit} = assigns, socket) do
    changeset = Permits.change_permit(permit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"permit" => permit_params}, socket) do
    changeset =
      socket.assigns.permit
      |> Permits.change_permit(permit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"permit" => permit_params}, socket) do
    save_permit(socket, socket.assigns.action, permit_params)
  end

  defp save_permit(socket, :edit, permit_params) do
    case Permits.update_permit(socket.assigns.permit, permit_params) do
      {:ok, _permit} ->
        {:noreply,
         socket
         |> put_flash(:info, "Permit updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_permit(socket, :new, permit_params) do
    case Permits.create_permit(permit_params) do
      {:ok, _permit} ->
        {:noreply,
         socket
         |> put_flash(:info, "Permit created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
