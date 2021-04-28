defmodule LpcManagerWeb.Router do
  use LpcManagerWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LpcManagerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug LpcManager.Plugs.EnsureRolePlug, :admin
  end

  pipeline :user do
    plug LpcManager.Plugs.EnsureRolePlug, :user
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", LpcManagerWeb do
    pipe_through :browser

    get "/", MainController, :index
  end

  scope "/user", LpcManagerWeb do
    pipe_through [:browser, :user]

    resources "/teams", TeamController
    get "/myTeams", TeamController, :index_my_teams
    get "/myTeams/prepare/:id", TeamController, :prepare_my_team
    get "/myTeams/dismiss/:id", TeamController, :dismiss_my_team
    get "/myTeams/manage", TeamController, :manage_my_team
    put "/myTeams/save_prepare/:id", TeamController, :save_prepare
    get "/myTeams/close_prepare/:id", TeamController, :close_prepare
  end

  scope "/admin", LpcManagerWeb do
    pipe_through [:browser, :admin]

    live "/", PageLive, :index

    resources "/races", RaceController
    resources "/traits", TraitController
    resources "/skills", SkillController
    resources "/roster_players", RosterPlayerController
    resources "/roster_teams", RosterTeamController
    resources "/players", PlayerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", LpcManagerWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:browser, :admin]
      live_dashboard "/dashboard", metrics: LpcManagerWeb.Telemetry
    end
  end
end
