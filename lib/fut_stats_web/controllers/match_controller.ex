defmodule FutStatsWeb.MatchController do
    use FutStatsWeb, :controller

    def matches_for_league_season(conn, %{"league" => league, "season" => season, "format" => format}) do
        data = FutStats.Queries.Matches.list_matches_for_league_season(league, season)
        case format do
            "proto" -> render(conn, "index.proto", matches: data)
            _ -> render(conn, "index.json", matches: data)
        end
    end
end