defmodule FutStatsWeb.LeagueView do

    use FutStatsWeb, :view
    
    alias FutStatsWeb.LeagueView

    def render("index.json", %{leagues: leagues}) do
        %{data: render_many(leagues, LeagueView, "league.json")}
    end

    def render("league.json", %{league: ls}) do
        %{
            league: ls.league,
            season: ls.season 
        }
    end
        
    def render("index.proto",  %{leagues: leagues}) do
        leagues_proto = Enum.map(leagues, fn ls -> schema_to_proto(ls)  end) 
        Protos.Leagues.new(leagues: leagues_proto) |> Protos.Leagues.encode
    end

    def schema_to_proto(ls) do
        Protos.League.new(
            league: ls.league,
            season: ls.season
        )
    end
end