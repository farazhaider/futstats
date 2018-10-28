defmodule FutStats.Match do
  use Ecto.Schema

  schema "matches" do
    field :league
    field :season
    field :m_date, :date
    field :home_team 
    field :away_team
    field :hthg, :integer
    field :htag, :integer
    field :fthg, :integer
    field :ftag, :integer
    field :htr
    field :ftr
  end
    
end