defmodule GovernWeb.PostLive.Index do
  use GovernWeb, :live_view

  alias Govern.{
    Feed,
    Feed.Post,
    Permits,        
    Permits.Permit,    
    News,
    Users,
    Users.User
  }
  alias GovernWeb.LiveViewCredentials


  @impl true
  def mount(_params, session, socket) do

    current_user  = LiveViewCredentials.get_user(socket, session)
    changeset     = Feed.change_post(%Post{})
    articles      = News.list_articles()
    page_title    = "Welcome to Pantry Govern"
    posts         = Feed.list_posts()
    permits         = Permits.list_permits()    
    socket = 
      assign(socket,
        current_user: current_user,
        changeset: changeset,
        page_title: page_title,
        articles: articles,
        permits: permits,
        posts: posts
      )
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Feed.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Feed.get_post!(id)
    {:ok, _} = Feed.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts())}
  end

  @impl true
  def handle_event("save", %{"post" => post_params}, socket) do
    case Feed.create_post(post_params) do
      {:ok, post} ->
        socket = 
          update(
            socket,
            :posts,
            fn posts -> [post | posts] end
          )
        changeset = Feed.change_post(%Post{})
        socket = assign(socket, changeset: changeset)
        {:noreply,
         socket
        }
      {:error, %Ecto.Changeset{} = changeset} -> {:noreply, assign(socket, :changeset, changeset)}
    end
  end  

  defp list_posts do
    Feed.list_posts()
  end
end
