# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FutStats.Repo.insert!(%FutStats.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

#Ensures the database is clean before inserting data
FutStats.Repo.delete_all FutStats.Match

#Opens the data file as a stream and calls the utility function
File.stream!("Data.csv") |> FutStats.Utils.insert_records