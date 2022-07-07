defmodule GovernWeb.PermitLive.Index do
  use GovernWeb, :live_view

  alias Govern.{
    Permits,
    Permits.Permit
  }

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Permits.subscribe()
    
    {:ok, assign(socket, :permits, list_permits())}



  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Permit")
    |> assign(:permit, Permits.get_permit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Permit")
    |> assign(:permit, %Permit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Permits")
    |> assign(:permit, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    permit = Permits.get_permit!(id)
    {:ok, _} = Permits.delete_permit(permit)

    {:noreply, assign(socket, :permits, list_permits())}
  end


  def handle_event("process", %{"id" => id}, socket) do
    permit = Permits.get_permit!(id)

    {:ok, _permit} = Permits.update_permit(permit, %{step: "processing"})

    permits = Permits.list_permits()

    socket = assign(socket, permits: permits)
    {:noreply, socket}
  end

  def handle_event("wait", %{"id" => id}, socket) do
    permit = Permits.get_permit!(id)

    {:ok, _permit} = Permits.update_permit(permit, %{step: "waiting"})

    permits = Permits.list_permits()

    socket = assign(socket, permits: permits)
    {:noreply, socket}
  end


  def handle_info({:permit_updated, permit}, socket) do
    # case Permits.update_permit(params) do
    #   {:ok, permit} ->
    socket =
      update(socket,
        :permits,
        fn permits -> [ permits ] end 
      )
    
    {:noreply, socket}
  end


  defp list_permits do
    Permits.list_permits()
  end
end
