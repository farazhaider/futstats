defmodule FutStatsWeb.Plugs.Metrics do
  
  use Instruments

  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do

    Instruments.increment("futstats.request.count")
    
    req_start_time = :os.timestamp

    register_before_send(conn, fn conn ->  
      # increment count
      Instruments.increment("futstats.response.count")

      # log response time in microseconds
      req_end_time = :os.timestamp
      duration = :timer.now_diff(req_end_time, req_start_time)
      Instruments.histogram("futstats.response.time", duration)

      conn
    end)

  end
end