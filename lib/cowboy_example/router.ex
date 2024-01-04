defmodule CowboyExample.Router do
  @moduledoc """
  This module is responsible for defining the routes for the Cowboy HTTP server.
  """
  require Logger

  @doc """
  Returns the routes for the Cowboy HTTP server.
  """
  def routes do
    [
      # We put __MODULE__ as the handler module because this module is where
      # the init/2 function is defined (in this case).
      {:_, [{"/", __MODULE__, []}]}
    ]
  end

  @doc """
  This function is called when a request is received by the Cowboy HTTP server.
  """
  def init(req, state) do
    Logger.info("Request received: #{inspect(req)}")

    res = :cowboy_req.reply(
      200,
      %{"content-type" => "text/html"},
      "Hello World!",
      req
    )

    {:ok, res, state}
  end
end
