defmodule FutStats.Repo.Metrics do
  use Instruments

  def record(entry) do
    Instruments.histogram("futstats.query.exec_time", entry.query_time + (entry.queue_time || 0))
    Instruments.histogram("futstats.query.queue_time", entry.queue_time || 0)
    Instruments.increment("futstats.query.count")
  end
end
