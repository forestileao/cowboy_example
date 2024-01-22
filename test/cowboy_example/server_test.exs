defmodule CowboyExample.ServerTest do
  use ExUnit.Case, async: true

  setup_all do
    Finch.start_link(name: CowboyExample.Finch)
    :ok
  end

  describe "GET /" do
    test "returns Hello World with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/")
        |> Finch.request(CowboyExample.Finch)

      assert response.status == 200
      assert response.body == "Hello World!"
      assert {"content-type", "text/html"} in response.headers
    end
  end

  describe "GET /greet/:who" do
    test "returns 'Hello' greeting for param 'who' with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/greet/John")
        |> Finch.request(CowboyExample.Finch)

      assert response.status == 200
      assert response.body == "Hello John"
      assert {"content-type", "text/html"} in response.headers
    end

    test "returns defined param 'greeting' for param 'who' with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/greet/John?greeting=Hey")
        |> Finch.request(CowboyExample.Finch)

      assert response.status == 200
      assert response.body == "Hey John"
      assert {"content-type", "text/html"} in response.headers
    end
  end

end
