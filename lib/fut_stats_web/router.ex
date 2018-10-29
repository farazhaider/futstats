defmodule FutStatsWeb.Router do
  use FutStatsWeb, :router
  use PhoenixSwagger

  pipeline :api do
    plug :accepts, ["json"]
    plug FutStatsWeb.Plugs.Metrics
  end

  scope "/api", FutStatsWeb do
    pipe_through :api

    get "/leagues_with_season", LeagueController, :leagues_with_season
    get "/matches_for_league_season", MatchController, :matches_for_league_season

  end

  def swagger_info do
    %{
      info: %{
        version: "0.0.1",
        title: "FutStats",
        host: "35.231.29.153"
      }
    }
  end

  scope "/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :fut_stats,
      swagger_file: "swagger.json",
      disable_validator: true
  end
end
