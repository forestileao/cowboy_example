defmodule CowboyExample.Router do
  @moduledoc """
  This module is responsible for defining the routes for the Cowboy HTTP server.
  """
  alias CowboyExample.Handlers.{Root, Greet, Static}
  require Logger

  @doc """
  Returns the routes for the Cowboy HTTP server.
  """
  def routes do
    [
      # We put __MODULE__ as the handler module because this module is where
      # the init/2 function is defined (in this case).
      {:_, [
        {"/", Root, []},
        {"/greet/:who", [who: :nonempty], Greet, []},
        {"/static/:page", [page: :nonempty], Static, []}
      ]}
    ]
  end


end
