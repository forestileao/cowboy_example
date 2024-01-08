defmodule CowboyExample.Handlers.Static do
  @moduledoc """
  This function is called when a request is received on route /static/:page.
  """
  require Logger

  def init(req, state) do
    Logger.info("Request received: #{inspect(req)}")
    page = :cowboy_req.binding(:page, req)

    res = case html_for(page) do
      {:ok, html} ->
        :cowboy_req.reply(
          200,
          %{"content-type" => "text/html"},
          html,
          req
        )
      _ ->
        :cowboy_req.reply(
          404,
          %{"content-type" => "text/html"},
          "Not Found",
          req
        )
    end

    {:ok, res, state}
  end

  defp html_for(page) do
    priv_dir = :code.priv_dir(:cowboy_example) |> to_string()

    page_path = Path.join([priv_dir, "static", page])
    File.read(page_path)
  end
end
