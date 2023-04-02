defmodule School.Helpers do
  @moduledoc """
  provides helper functions
  """

  import Ecto.Query, warn: false

  @paging 20

  def get_paging, do: @paging

  @doc """
  make query to filter results
  """
  def make_filters(query, nil), do: query
  def make_filters(query, ""), do: query
  def make_filters(query, value) do
    Enum.reduce(query.get_attrs(), query, fn key, query ->
      from q in query, or_where: ilike(field(q, ^key), ^"%#{value}%")
    end)
  end


  def paging_query(query, page_num) do
    query
    |> limit(@paging)
    |> offset(^(page_num - 1))
  end

  def get_total_pages(query) do
    records = School.Repo.aggregate(query, :count, :id)
    ceil(records / @paging)
  end

end
