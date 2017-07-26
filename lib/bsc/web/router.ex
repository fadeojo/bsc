defmodule Bsc.Web.Router do
  use Bsc.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Bsc.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Bsc.Web do
    pipe_through :api
    resources "/orgs", OrgController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit] do 
      resources "/patients", PatientController, except: [:new, :edit]
    end
    resources "/rooms", RoomController, except: [:new, :edit]
    resources "/patients", PatientController, except: [:new, :edit]
    post "/login", AuthController, :login
    post "/radar", DeviceController, :create
  end
end
