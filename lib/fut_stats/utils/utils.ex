defmodule FutStats.Utils do
  @moduledoc """
  Utilized by the `seed.exs` for seeding the database. Reads the `Data.csv` file as a stream,
  maps each record to the corresponding Ecto Schema and inserts it into the database.
  """

  @doc """
  Converts the `map` obtained from a csv line to an `Ecto.Schema`

  ## Parameters

    - record: `map` representing a csv line
  """
  def insert_record(record) do
    match = %FutStats.Match{
      league: record["Div"],
      season: record["Season"],
      m_date:
        :erlang.apply(
          Date,
          :new,
          String.split(record["Date"], "/")
          |> Enum.map(fn a -> String.to_integer(a) end)
          |> Enum.reverse()
        )
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

  @doc """
  Accepts a `File.Stream` object from the `seed.exs` script and calls `insert_record/1` 
  for each entry.

  ## Parameters

    - csv_stream: A `File.Stream`
  """
  def insert_records(csv_stream) do
    csv_stream
    |> Stream.map(&(&1))
    |> CSV.decode!(headers: true)
    |> Enum.map(fn x -> insert_record(x) end)
  end
end