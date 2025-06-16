let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\sprint_results.csv"),[Delimiter=",", Columns=16, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"resultId", Int64.Type}, {"raceId", Int64.Type}, {"driverId", Int64.Type}, {"constructorId", Int64.Type}, {"number", Int64.Type}, {"grid", Int64.Type}, {"position", type text}, {"positionText", type text}, {"positionOrder", Int64.Type}, {"points", Int64.Type}, {"laps", Int64.Type}, {"time", type text}, {"milliseconds", type text}, {"fastestLap", type text}, {"fastestLapTime", type text}, {"statusId", Int64.Type}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"raceId"}, Races, {"raceId"}, "Races", JoinKind.Inner),
    #"Expanded Races" = Table.ExpandTableColumn(#"Merged Queries", "Races", {"raceId", "year", "round", "circuitId", "name", "sprint_date", "sprint_time"}, {"Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name", "Races.sprint_date", "Races.sprint_time"})
in
    #"Expanded Races"