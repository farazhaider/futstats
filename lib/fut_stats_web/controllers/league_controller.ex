defmodule FutStatsWeb.LeagueController do
    use FutStatsWeb, :controller

    def leagues_with_season(conn, %{"format" => format}) do
        data = FutStats.Queries.Leagues.list_leagues_with_season()
        case format do
            "proto" -> render(conn, "index.proto", leagues: data)
            _ -> render(conn, "index.json", leagues: data)
        end
    end
end