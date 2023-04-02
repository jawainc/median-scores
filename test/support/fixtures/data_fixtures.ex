defmodule School.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `School.Medians` context.
  """

  alias School.Medians
  alias School.Repo

  @attrs %{
    "rank" => "2",
    "school" => "Yale University",
    "first_year_class" => 2022,
    "l75" => 160,
    "l50" => 150,
    "l25" => 130,
    "g75" => 3.85,
    "g50" => 3.45,
    "g25" => 3.22,
    "gre75v" => 130,
    "gre50v" => 150,
    "gre25v" => 160,
    "gre75q" => 165,
    "gre50q" => 160,
    "gre25q" => 175,
    "gre75w" => 4.0,
    "gre50w" => 3.5,
    "gre25w" => 3.9
  }

  @doc """
  Generate data.
  """
  def data_fixture() do
    changeset = Medians.Data.changeset(%Medians.Data{}, @attrs)
    Repo.insert!(changeset)
  end
end
