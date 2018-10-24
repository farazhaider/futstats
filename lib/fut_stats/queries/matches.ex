defmodule FutStats.Queries.Matches do
  import Ecto.Query

  def list_matches_for_league_season(league, season) do
    query =
      from(m in FutStats.Match,
           where: m.league == ^league and m.season == ^season,
           select: m 
           )

    FutStats.Repo.all(query)
  end
end
