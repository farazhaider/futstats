defmodule FutStatsWeb.Router do
  use FutStatsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FutStatsWeb do
    pipe_through :api

    get "/leagues_with_season", LeagueController, :leagues_with_season
    get "/matches_for_league_season", MatchController, :matches_for_league_season

  end
end
