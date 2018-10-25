defmodule FutStatsWeb.MatchView do

    use FutStatsWeb, :view
    
    alias FutStatsWeb.MatchView

    def render("index.json", %{matches: matches}) do
        %{data: render_many(matches, MatchView, "match.json")}
    end

    def render("match.json", %{match: match}) do
        %{
            m_date: match.m_date,
            home_team: match.home_team,
            away_team: match.away_team,
            hthg: match.hthg,
            htag: match.htag,
            fthg: match.fthg,
            ftag: match.ftag,
            htr: match.htr,
            ftr: match.ftr
        }
    end

    def render("index.proto",  %{matches: matches}) do
        matches_proto = Enum.map(matches, fn match -> schema_to_proto(match)  end) 
        Protos.Matches.new(matches: matches_proto) |> Protos.Matches.encode
    end

    def schema_to_proto(match) do
        Protos.Match.new(
            m_date: Date.to_string(match.m_date),
            home_team: match.home_team,
            away_team: match.away_team,
            hthg: match.hthg,
            htag: match.htag,
            fthg: match.fthg,
            ftag: match.ftag,
            htr: match.htr,
            ftr: match.ftr
        )
    end

end