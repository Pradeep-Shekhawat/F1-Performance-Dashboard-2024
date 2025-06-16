let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\constructors.csv"),[Delimiter=",", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"constructorId", Int64.Type}, {"constructorRef", type text}, {"name", type text}, {"nationality", type text}, {"url", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"constructorId"}, Results, {"constructorId"}, "Results", JoinKind.Inner),
    #"Expanded Results" = Table.ExpandTableColumn(#"Merged Queries", "Results", {"resultId", "raceId", "driverId", "constructorId", "number", "grid", "position", "positionText", "positionOrder", "points", "laps", "time", "milliseconds", "fastestLap", "rank", "fastestLapTime", "fastestLapSpeed", "statusId", "Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name", "Races.date", "Races.time"}, {"Results.resultId", "Results.raceId", "Results.driverId", "Results.constructorId", "Results.number", "Results.grid", "Results.position", "Results.positionText", "Results.positionOrder", "Results.points", "Results.laps", "Results.time", "Results.milliseconds", "Results.fastestLap", "Results.rank", "Results.fastestLapTime", "Results.fastestLapSpeed", "Results.statusId", "Results.Races.raceId", "Results.Races.year", "Results.Races.round", "Results.Races.circuitId", "Results.Races.name", "Results.Races.date", "Results.Races.time"}),
    #"Removed Duplicates" = Table.Distinct(#"Expanded Results", {"constructorId"}),
    #"Removed Columns" = Table.RemoveColumns(#"Removed Duplicates",{"url"})
in
    #"Removed Columns"