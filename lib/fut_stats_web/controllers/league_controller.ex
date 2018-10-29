defmodule FutStatsWeb.LeagueController do
    @moduledoc """
    Controller for `/leagues_with_season` route. Contains only a single method `leagues_with_season/2`
    which send the unique league season pairs as response. Calls `FutStats.Queries.Leagues.list_leagues_with_season/0`
    Accepts a single parameter in the query string called `format` which can be `proto` or `json`
    """

    use FutStatsWeb, :controller
    use PhoenixSwagger

    swagger_path :leagues_with_season do
        get "/api/leagues_with_season"
        summary "List of league and season pairs"
        description "List of unique league and season pairs"
        parameters do
            format :path, :string, "Type of response: json or proto", required: true
        end
        response 200, "Ok", Schema.ref(:Leagues)
    end

    def leagues_with_season(conn, %{"format" => format}) do
        data = FutStats.Queries.Leagues.list_leagues_with_season()
        case format do
            "proto" -> render(conn, "index.proto", leagues: data)
            _ -> render(conn, "index.json", leagues: data)
        end
    end

    def swagger_definitions do
        %{
          League: swagger_schema do
            title "League"
            description "A League and Season pair"
            properties do
              league :string, "Name of the league", required: true
              season :string, "Season for the league", required: true
            end
            example %{
              league: "SP1",
              season: "201617"
            }
          end,
          Leagues: swagger_schema do
            title "Leagues"
            description "List of unique League and Season pairs"
            type :array
            items Schema.ref(:League)
            example %{
              league: "SP1",
              season: "201617"
            }
          end
        }
    end
end