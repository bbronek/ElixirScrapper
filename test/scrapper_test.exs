defmodule ScrapperTest do

  alias Scrapper
  alias Errors.Error, as: E
  use ExUnit.Case

  describe "Testing functions from Scrapper module" do
    test "check if function exists_content is valid" do
      assert Scrapper.exist_content?([0])
    end

  end



end
