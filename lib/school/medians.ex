defmodule School.Medians do
  @moduledoc """
  The Medians context.
  """

  import Ecto.Query, warn: false
  alias School.{Repo, Medians.Data, Helpers}

  @doc """
  Returns the list of schools.

  ## Examples

      iex> list_school_data()
      [%Data{}, ...]
  """
  def list_school_data(%{:page => page, :filter => value}) do
    Repo.all(
      Data
      |> Helpers.make_filters(value)
      |> Helpers.paging_query(page)
      |> order_by(desc: :first_year_class)
    )
  end

  @doc """
  Gets records for school.

  ## Examples

      iex> get_school(id)
      %Data{}
  """
  def get_school!(id) do
    Repo.get!(Data, id)
  end
end
