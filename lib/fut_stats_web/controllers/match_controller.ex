defmodule FutStatsWeb.MatchController do
    @moduledoc """
    Controller for `/matches_for_league_season` route. Contains only a single method `matches_for_league_season/2`
    which send the matches for a particular league season pair as response.
    Calls `FutStats.Queries.Matches.list_matches_for_league_season/2`
    Accepts 3 parameters in the query string, `league`, `season` and `format`
    """
    use FutStatsWeb, :controller

    use PhoenixSwagger

    def swagger_definitions do
        %{
        Match: swagger_schema do
            title "Match"
            description "Details of a match"
            properties do
              date :string, "Match's date of play", required: true
              home_team :string, "The home team", required: true
              away_team :string, "The away team", required: true
              hthg :integer, "Half time home team goals", required: true
              htag :integer, "Half time away team goals", required: true
              fthg :integer, "Full time home team goals", required: true
              ftag :integer, "Full time away team goals", required: true
              htr :string, "Half time result", required: true
              ftr :string, "Full time result", required: true
            end
            example %{
              date: "SP1",
              home_team: "Barcelona",
              away_team: "Betis",
              hthg: 3,
              htag: 1,
              fthg: 6,
              ftag: 2,
              htr: "H",
              ftr: "H"
            }
        end,
        Matches: swagger_schema do
            title "Matches"
            description "List of matches"
            type :array
            items Schema.ref(:Match)
        end
        }
    end

    swagger_path :matches_for_league_season do
        get "/api/matches_for_league_season"
        summary "List of matches"
        description "List of matches for a league and season"
        parameters do
            league :path, :string, "League for the match", required: true
            season :path, :string, "Season for the match", required: true
            format :path, :string, "Type of response: json or proto", required: true
        end
        response 200, "Ok", Schema.ref(:Matches)
    end
    
    def matches_for_league_season(conn, %{"league" => league, "season" => season, "format" => format}) do
        data = FutStats.Queries.Matches.list_matches_for_league_season(league, season)
        case format do
            "proto" -> render(conn, "index.proto", matches: data)
            _ -> render(conn, "index.json", matches: data)
        end
    end
end