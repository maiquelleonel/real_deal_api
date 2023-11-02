defmodule RealDealApiWeb.Router do
  alias RealDealApiWeb

  use RealDealApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RealDealApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    get "/accounts", AccountController, :index
    post "/accounts", AccountController, :create
    get "/accounts/:id", AccountController, :show
    put "/accounts/:id", AccountController, :update
    delete "/accounts/:id", AccountController, :delete
    get "/users", UserController, :index
    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
  end
end
