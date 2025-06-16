let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\drivers.csv"),[Delimiter=",", Columns=9, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"driverId", Int64.Type}, {"driverRef", type text}, {"number", type text}, {"code", type text}, {"forename", type text}, {"surname", type text}, {"dob", type date}, {"nationality", type text}, {"url", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"driverId"}, Results, {"driverId"}, "Results", JoinKind.Inner),
    #"Expanded Results" = Table.ExpandTableColumn(#"Merged Queries", "Results", {"resultId", "raceId", "driverId", "constructorId", "number", "grid", "position", "positionText", "positionOrder", "points", "laps", "time", "milliseconds", "fastestLap", "rank", "fastestLapTime", "fastestLapSpeed", "statusId", "Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name", "Races.date", "Races.time"}, {"Results.resultId", "Results.raceId", "Results.driverId", "Results.constructorId", "Results.number", "Results.grid", "Results.position", "Results.positionText", "Results.positionOrder", "Results.points", "Results.laps", "Results.time", "Results.milliseconds", "Results.fastestLap", "Results.rank", "Results.fastestLapTime", "Results.fastestLapSpeed", "Results.statusId", "Results.Races.raceId", "Results.Races.year", "Results.Races.round", "Results.Races.circuitId", "Results.Races.name", "Results.Races.date", "Results.Races.time"}),
    #"Removed Duplicates" = Table.Distinct(#"Expanded Results", {"driverId"}),
    #"Removed Columns" = Table.RemoveColumns(#"Removed Duplicates",{"url"})
in
    #"Removed Columns"