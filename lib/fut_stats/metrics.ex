defmodule FutStats.Repo.Metrics do
  @moduledoc """
  Metrics for Ecto queries, reported using the `Instruments` package and the StatsD server.
  Measures query count and execution times. Defined as one of the `:loggers` in Ecto's config in dev.exs
  """
  use Instruments

  def record(entry) do
    Instruments.histogram("futstats.query.exec_time", entry.query_time + (entry.queue_time || 0))
    Instruments.histogram("futstats.query.queue_time", entry.queue_time || 0)
    Instruments.increment("futstats.query.count")
  end
end
