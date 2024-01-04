defmodule CowboyExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Task, fn -> CowboyExample.Server.start(4040) end}
    ]

    opts = [strategy: :one_for_one, name: CowboyExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
