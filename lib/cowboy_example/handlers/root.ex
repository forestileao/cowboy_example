defmodule CowboyExample.Handlers.Root do
  @doc """
  This function is called when a request is received by the Cowboy HTTP server.
  """
  require Logger


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
