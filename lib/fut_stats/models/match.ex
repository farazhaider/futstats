defmodule FutStats.Match do
  use Ecto.Schema

  @type result :: "W" | "L" | "D"
  @type goals :: pos_integer

  schema "matches" do
    field :league
    field :season
    field :m_date, :date
    field :home_team 
    field :away_team
    field :hthg, :goals
    field :htag, :goals
    field :fthg, :goals
    field :ftag, :goals
    field :htr, :result
    field :ftr, :result
  end
    
end


# Dynamically calculate ftr and htr if necessary
# put teams in a different table and use their id's in match schema
# make a type for htr and ftr which has 3 value H D A