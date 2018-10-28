defmodule FutStats.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fut_stats,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Docs
      name: "FutStats",
      source_url: "https://github.com/farazhaider/futstats",
      homepage_url: "https://github.com/farazhaider/futstats",
      docs: [
        # The main page in the docs
        main: "FutStats",
        extras: ["README.md"],
        groups_for_modules: groups_for_modules()
      ]
    ]
  end

  def groups_for_modules do
    [
      Main: [
        FutStats
      ],
      Controllers: [
        FutStatsWeb.LeagueController,
        FutStatsWeb.MatchController
      ],
      Utils: [
        FutStats.Utils
      ],
      Metrics: [
        FutStats.Repo.Metrics,
        FutStatsWeb.Plugs.Metrics
      ],
      Models: [
        FutStats.Match,
        Protos
      ],
      Queries: [
        FutStats.Queries.Leagues,
        FutStats.Queries.Matches
      ],
      Views: [
        FutStatsWeb.LeagueView,
        FutStatsWeb.MatchView
      ],
      Miscellaneous: [
        FutStats.Application,
        FutStats.Repo,
        FutStatsWeb,
        FutStatsWeb.Gettext,
        FutStatsWeb.Router,
        FutStatsWeb.Router.Helpers,
        FutStatsWeb.ErrorHelpers
      ]
    ]
  end


  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {FutStats.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:plug_cowboy, "~> 1.0"},
      {:csv, "~> 2.0.0"},
      {:exprotobuf, "~> 1.2"},
      {:distillery, "~> 2.0"},
      {:instruments, "~> 1.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
