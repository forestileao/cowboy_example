defmodule CowboyExample.Handlers.Greet do
  @moduledoc """
  This module is responsible for handling requests to the greet path
  """
  require Logger

  @default_greeting "Hello"

  @doc """
  This function is called when a request is received by the Cowboy HTTP server.
  """
  def init(%{method: "GET"} = req, state) do
    Logger.info("Request received: #{inspect(req)}")
    greeting =
      req |>
      :cowboy_req.parse_qs()
      |> Enum.into(%{})
      |> Map.get("greeting", @default_greeting)
    who = :cowboy_req.binding(:who, req)

    res = :cowboy_req.reply(
      200,
      %{"content-type" => "text/html"},
      "#{greeting} #{who}",
      req
    )

    {:ok, res, state}
  end

  def init(req, state) do
    Logger.info("Request received: #{inspect(req)}")
    res = :cowboy_req.reply(
      405,
      %{"content-type" => "text/html"},
      "Method Not Allowed",
      req
    )

    {:ok, res, state}
  end
end
