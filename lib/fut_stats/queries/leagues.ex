defmodule FutStats.Queries.Leagues do
  @moduledoc """
  An ecto query which lists all the unique league season pairs.
  Uses `Ecto.Query.group_by/3` to group leage and season columns.
  """

  import Ecto.Query
  

  def list_leagues_with_season do
    from(m in FutStats.Match, group_by: [:league, :season], select: map(m, [:league, :season]))
    |> FutStats.Repo.all()
  end
end
