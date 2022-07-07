defmodule GovernWeb.PermitLive.Show do
  use GovernWeb, :live_view

  alias Govern.Permits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:permit, Permits.get_permit!(id))}
  end

  defp page_title(:show), do: "Show Permit"
  defp page_title(:edit), do: "Edit Permit"
end
