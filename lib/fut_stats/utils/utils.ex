defmodule FutStats.Utils do

    @csv_format ["id", "league", "season", "m_date", "home_team", "away_team",
                 "fthg", "ftag", "ftr", "hthg", "htag", "htr"
                ]
    
    def insert_record(record) do
        match = %FutStats.Match{
            league: record["Div"],
            season: record["Season"],
            m_date: :erlang.apply(Date, :new, String.split(record["Date"], "/") 
                                               |> Enum.map(fn a -> String.to_integer(a) end) 
                                               |> Enum.reverse) 
                                               |> elem(1),
            home_team: record["HomeTeam"],
            away_team: record["AwayTeam"],
            fthg: String.to_integer(record["FTHG"]),
            ftag: String.to_integer(record["FTAG"]),
            ftr: record["FTR"],
            hthg: String.to_integer(record["HTHG"]),
            htag: String.to_integer(record["HTAG"]),
            htr: record["HTR"]
        }

        FutStats.Repo.insert!(match)
    end

    def insert_records(csv_stream) do
        csv_stream 
        |> Stream.map(&(&1)) 
        |> CSV.decode!(headers: true)
        |> Enum.map(fn x -> insert_record(x) end)
    end
end