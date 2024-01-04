defmodule CowboyExample.Server do
  @moduledoc """
  This module is responsible for defining and starting the Cowboy HTTP server.
  """

  def start(port) do
    routes = CowboyExample.Router.routes()
    dispatch_rules = :cowboy_router.compile(routes)

    {:ok, _pid} =
      :cowboy.start_clear(
        :listener,
        [{:port, port}],
        %{env: %{dispatch: dispatch_rules}}
      )
  end
end
