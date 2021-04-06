defmodule Scrapper do
  def get_data do

    HTTPoison.start

    case HTTPoison.get("https://en.wikipedia.org/wiki/Elixir_(programming_language)") do
      {:ok, %HTTPoison.Response{body: body}} ->
        content = body
           |> Floki.find("h2>span")
           |> Floki.attribute("id")

        {:ok, content}
    end
  end

  def print_content({_, content}) do
    Enum.map(content, fn s ->
      IO.puts " " <> s
      IO.puts "================"
    end)
  end

end
