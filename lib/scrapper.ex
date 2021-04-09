defmodule Scrapper do

  @moduledoc """
  Module contains four functions get_data, print_contents, error_check, exist_content?

  ## Description of the functions

      get_data - takes titles from wikipedia page by using HTTPoison and Floki
      print_contetnt - prints out titles
      error_check - checks if url address is valid and if it is a wikipedia page
      exist_content? - checks if given page contains titles or exists

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

  alias Errors

  def error_check(page) do
    cond do
      not String.match?(page, ~r/^https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,}/) ->
        raise Errors.Error.Url
      not String.match?(page, ~r/^https?\:\/\/([\w\.]+)wikipedia.org\/wiki\/([\w]+\_?)+/) ->
        raise Errors.Error.Wikipedia
      true ->
       nil
    end
  end

  def exist_content?(content) do
    if content == [] do
        false
    else
        true
    end
  end

  def get_data(page) do
    error_check(page)

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
    if exist_content?(content) do
    Enum.map(content, fn s ->
      IO.puts " " <> s
      IO.puts "================"
    end)
    else
      raise "Website doesn't exist or it doesn't contain any titles"
    end
  end

end
