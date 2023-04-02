# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     School.Repo.insert!(%School.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias School.Medians
alias School.Repo

defmodule School.Seeds do

  def store({:ok, row}) do
    changeset = Medians.Data.changeset(%Medians.Data{}, row)
    Repo.insert!(changeset)
  end

end

{:ok, current_dir} = File.cwd()
File.stream!("#{current_dir}/priv/repo/data.csv")
  |> Stream.drop(1)
  |> CSV.decode(headers: Medians.Data.get_fields())
  |> Enum.each(&School.Seeds.store/1)
