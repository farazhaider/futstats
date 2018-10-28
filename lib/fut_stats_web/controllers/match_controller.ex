defmodule FutStatsWeb.MatchController do
    @moduledoc """
    Controller for `/matches_for_league_season` route. Contains only a single method `matches_for_league_season/2`
    which send the matches for a particular league season pair as response.
    Calls `FutStats.Queries.Matches.list_matches_for_league_season/2`
    Accepts 3 parameters in the query string, `league`, `season` and `format`
    """
    use FutStatsWeb, :controller

    def matches_for_league_season(conn, %{"league" => league, "season" => season, "format" => format}) do
        data = FutStats.Queries.Matches.list_matches_for_league_season(league, season)
        case format do
            "proto" -> render(conn, "index.proto", matches: data)
            _ -> render(conn, "index.json", matches: data)
        end
    end
end