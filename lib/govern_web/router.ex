defmodule GovernWeb.Router do
  use GovernWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GovernWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end


  scope "/", GovernWeb do
    pipe_through [:browser, :protected]

    resources "/articles", ArticleController
    get "/bus", PageController, :bus
    get "/jeep", PageController, :jeep    
    get "/tricycle", PageController, :tricycle
    
    live "/", PostLive.Index, :index
    live "/posts/new", PostLive.Index, :new
    live "/posts/:id/edit", PostLive.Index, :edit

    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/show/edit", PostLive.Show, :edit

    live "/permits", PermitLive.Index, :index
    live "/permits/new", PermitLive.Index, :new
    live "/permits/:id/edit", PermitLive.Index, :edit

    live "/permits/:id", PermitLive.Show, :show
    live "/permits/:id/show/edit", PermitLive.Show, :edit

    resources "/pantries", PantryController
    resources "/documents", DocumentController
    resources "/users", UserController
  end





  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GovernWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
