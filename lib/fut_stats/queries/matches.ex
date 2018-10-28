defmodule FutStats.Queries.Matches do
  @moduledoc """
  An ecto query which lists all the matches pertaining to a league and season pair.
  """

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
