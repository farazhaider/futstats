defmodule FutStatsWeb.LeagueController do
    use FutStatsWeb, :controller

    use Instruments

    def leagues_with_season(conn, %{"format" => format}) do
        Instruments.increment("futstats.total_requests", 1)
        data = FutStats.Queries.Leagues.list_leagues_with_season()
        case format do
            "proto" -> render(conn, "index.proto", leagues: data)
            _ -> render(conn, "index.json", leagues: data)
        end
    end
end