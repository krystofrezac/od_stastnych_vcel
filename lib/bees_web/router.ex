# credo:disable-for-this-file Credo.Check.Refactor.ModuleDependencies

defmodule BeesWeb.Router do
  use BeesWeb, :router

  import BeesWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :public do
    plug :put_root_layout, {BeesWeb.Public.LayoutView, :root}
  end

  pipeline :admin do
    plug :put_root_layout, {BeesWeb.Admin.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BeesWeb.Public.Live do
    pipe_through [:browser, :public]

    live_session :public do
      live "/", Home.Index, :index

      live "/products", Products.Index, :index
      live "/product", Product.Index, :index

      live "/gallery", Gallery.Index, :index
      live "/gallery/show", Gallery.Index, :show
    end
  end

  scope "/admin", BeesWeb.Admin.Live do
    pipe_through [:browser, :admin, :require_authenticated_user]

    live_session :admin, on_mount: BeesWeb.Admin.Live.UserAuthHook do
      live "/", Dashboard.Index, :index

      live "/account", Account.Index, :index

      live "/users", Users.Index, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeesWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Application.fetch_env!(:bees, :env) in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BeesWeb.Telemetry

      # Enables the Swoosh mailbox preview in development.
      #
      # Note that preview only shows emails that were sent by the same
      # node running the Phoenix server.
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", BeesWeb.Admin do
    pipe_through [:browser, :admin, :redirect_if_user_is_authenticated]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", BeesWeb.Admin do
    pipe_through [:browser, :admin, :require_authenticated_user]

    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", BeesWeb.Admin do
    pipe_through [:browser, :admin]

    delete "/users/log_out", UserSessionController, :delete
  end
end
