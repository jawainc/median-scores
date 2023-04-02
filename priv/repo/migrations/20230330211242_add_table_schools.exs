defmodule School.Repo.Migrations.AddTableSchools do
  use Ecto.Migration

  def change do
    create table(:schools) do
      add :rank, :string
      add :school, :string
      add :first_year_class, :integer
      add :l75, :integer
      add :l50, :integer
      add :l25, :integer
      add :g75, :float
      add :g50, :float
      add :g25, :float
      add :gre75v, :integer
      add :gre50v, :integer
      add :gre25v, :integer
      add :gre75q, :integer
      add :gre50q, :integer
      add :gre25q, :integer
      add :gre75w, :float
      add :gre50w, :float
      add :gre25w, :float
    end
  end
end
