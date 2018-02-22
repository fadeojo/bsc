defmodule Bsc.Application do
  @moduledoc """
  
  """
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Bsc.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Bsc.Web.Endpoint, []),
      # Start your own worker by calling: Bsc.Worker.start_link(arg1, arg2, arg3)
      # worker(Bsc.Worker, [arg1, arg2, arg3]),
      # worker(Mongo, [[database:
      #   Application.get_env(:bsc, :db)[:name],
      #   name: :bsc], ])

      worker(Mongo, [[database:
        Application.get_env(:bsc, :db)[:name],
        name: :bsc, 
        hostname: "ds147882.mlab.com",
        port: "47882",
        username: "admin",
        password: "mongoadmin"]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bsc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
