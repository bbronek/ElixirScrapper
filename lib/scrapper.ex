defmodule Scrapper do
  @moduledoc """
  Module contains two functions get_data and print_contents
  """
  @doc """
  Prints titles of wikipedia page.

  ## Parameters
    - page: String that represents a wikipedia page adress.

  ## Examples

    iex> Scrapper.get_data("https://en.wikipedia.org/wiki/Elixir_(programming_language)") |> Scrapper.print_content
            History
        ================
        Versioning
        ================
        Features
        ================
        Examples
        ================
        Noteworthy_Elixir_projects
        ================
        See_also
        ================
        References
        ================
        External_links
        ================
        [:ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok]

    """

  def get_data(page) do


    HTTPoison.start

    case HTTPoison.get(page) do
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
