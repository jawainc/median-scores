defmodule School.Medians.Data do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(rank school first_year_class l75 l50 l25 g75 g50 g25 gre75v gre50v gre25v gre75q gre50q gre25q gre75w gre50w gre25w)a

  schema "schools" do
    field :rank, :string
    field :school, :string
    field :first_year_class, :integer
    field :l75, :integer
    field :l50, :integer
    field :l25, :integer
    field :g75, :float
    field :g50, :float
    field :g25, :float
    field :gre75v, :integer
    field :gre50v, :integer
    field :gre25v, :integer
    field :gre75q, :integer
    field :gre50q, :integer
    field :gre25q, :integer
    field :gre75w, :float
    field :gre50w, :float
    field :gre25w, :float
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, @fields)
  end

  def get_fields(), do: @fields

  def get_attrs(), do: [:school]
end
