defmodule FutStats.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :league, :string
      add :season, :string
      add :m_date, :date
      add :home_team, :string
      add :away_team, :string
      add :hthg, :integer
      add :htag, :integer
      add :fthg, :integer
      add :ftag, :integer
      add :htr, :string
      add :ftr, :string
    end
  end
end