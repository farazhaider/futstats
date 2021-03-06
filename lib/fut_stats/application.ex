defmodule FutStats.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(FutStats.Repo, []),
      # Start the endpoint when the application starts
      supervisor(FutStatsWeb.Endpoint, [])
      # Start your own worker by calling: FutStats.Worker.start_link(arg1, arg2, arg3)
      # worker(FutStats.Worker, [arg1, arg2, arg3]),
    ]

    # Setup Instrument probes for monitoring the beam metrics
    setup_probes()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FutStats.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FutStatsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def setup_probes() do
    {:ok, _} = Application.ensure_all_started(:instruments)
    interval = 30_000

    Instruments.Probe.define(
      "erlang.process_count",
      :gauge,
      mfa: {:erlang, :system_info, [:process_count]},
      report_interval: interval
    )

    Instruments.Probe.define(
      "erlang.memory",
      :gauge,
      mfa: {:erlang, :memory, []},
      keys: [:total, :atom, :processes],
      report_interval: interval
    )

    Instruments.Probe.define(
      "erlang.statistics.run_queue",
      :gauge,
      mfa: {:erlang, :statistics, [:run_queue]},
      report_interval: interval
    )

    Instruments.Probe.define(
      "erlang.system_info.process_count",
      :gauge,
      mfa: {:erlang, :system_info, [:process_count]},
      report_interval: interval
    )
  end
end
