defmodule FutStats.Match do
  @moduledoc """
  An ecto schema whih defines the data model for our controllers. An `Ecto.Schema` directly
  maps to a database table. The column names have been deliberately chosen as small as it can be
  freely altered when rendering a view. This decouples the model and view.
  """
  
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