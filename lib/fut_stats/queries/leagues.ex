defmodule FutStats.Queries.Leagues do
  import Ecto.Query

  def list_leagues_with_season do
    from(m in FutStats.Match, group_by: [:league, :season], select: map(m, [:league, :season])) |> FutStats.Repo.all
  end
end

