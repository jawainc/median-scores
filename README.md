# Law School First Year Class

The technology stack: `Elixir`, `Phoenix framework`, `Liveviews` and `PostgreSQL`.

## Features
  * User can search school to view available data
  * User can view available median scores for selected school

## Elixir & Postgres Requirements

  This app requires the running Elixir and Postgres.

- [Elixir](https://elixir-lang.org/install.html) (app is using v1.14, but minimum requirement for Phoenix 1.11+)
- [Postgres](https://www.postgresql.org/download/) is installed on your system
- Operating System: Windows, macOS, or Linux


## How to setup and run

* Clone this repo.
* cd into the directory
* Make sure you have same elixir version as defined in `mix.exs`, otherwise change the elixir version to installed version in the file
* Install dependencies with `mix deps.get`
* Create, migrate and seed your database with `mix ecto.setup`. seed source csv file is in `priv/repo/data.csv`
* Start Phoenix endpoint with `mix phx.server`
* visit local site at http://localhost:4000
* Test with `mix test`
