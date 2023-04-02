defmodule School.DataTest do
  use School.DataCase

  import School.DataFixtures
  alias School.Medians

  describe "school data" do

    test "list_school_data/1 returns schools data" do
      data = data_fixture()
      assert Medians.list_school_data(%{page: 1, filter: nil}) == [data]
    end

    test "get_school!/1 returns the school with given id" do
      data = data_fixture()
      assert Medians.get_school!(data.id) == data
    end

  end
end
