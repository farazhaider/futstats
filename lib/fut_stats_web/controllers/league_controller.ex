defmodule FutStatsWeb.LeagueController do
    @moduledoc """
    Controller for `/leagues_with_season` route. Contains only a single method `leagues_with_season/2`
    which send the unique league season pairs as response. Calls `FutStats.Queries.Leagues.list_leagues_with_season/0`
    Accepts a single parameter in the query string called `format` which can be `proto` or `json`
    """

    use FutStatsWeb, :controller

    use Instruments

    def leagues_with_season(conn, %{"format" => format}) do
        data = FutStats.Queries.Leagues.list_leagues_with_season()
        case format do
            "proto" -> render(conn, "index.proto", leagues: data)
            _ -> render(conn, "index.json", leagues: data)
        end
    end
end