let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\results.csv"),[Delimiter=",", Columns=18, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"resultId", Int64.Type}, {"raceId", Int64.Type}, {"driverId", Int64.Type}, {"constructorId", Int64.Type}, {"number", Int64.Type}, {"grid", Int64.Type}, {"position", type text}, {"positionText", type text}, {"positionOrder", Int64.Type}, {"points", Int64.Type}, {"laps", Int64.Type}, {"time", type text}, {"milliseconds", type text}, {"fastestLap", type text}, {"rank", type text}, {"fastestLapTime", type text}, {"fastestLapSpeed", type text}, {"statusId", Int64.Type}}),
    #"Added Custom" = Table.AddColumn(#"Changed Type", "NumericPosition ", each try Number.FromText([position]) otherwise null),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Custom",{"resultId", "raceId", "driverId", "constructorId", "number", "grid", "position", "positionText", "NumericPosition ", "positionOrder", "points", "laps", "time", "milliseconds", "fastestLap", "rank", "fastestLapTime", "fastestLapSpeed", "statusId"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"position"}),
    #"Reordered Columns1" = Table.ReorderColumns(#"Removed Columns",{"resultId", "raceId", "driverId", "constructorId", "number", "grid", "NumericPosition ", "positionText", "positionOrder", "points", "laps", "time", "milliseconds", "fastestLap", "rank", "fastestLapTime", "fastestLapSpeed", "statusId"}),
    #"Renamed Columns" = Table.RenameColumns(#"Reordered Columns1",{{"NumericPosition ", "position"}}),
    #"Added Custom1" = Table.AddColumn(#"Renamed Columns", "PodiumFlag ", each if [position] <> null and [position] <= 3 then 1 else 0),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Custom1",{{"PodiumFlag ", Int64.Type}}),
    #"Added Custom2" = Table.AddColumn(#"Changed Type1", "PositionsGained ", each [grid] - [position]),
    #"Added Custom3" = Table.AddColumn(#"Added Custom2", "DNF ", each if Text.Contains([positionText], "R") then 1 else 0),
    #"Added Custom4" = Table.AddColumn(#"Added Custom3", "NumericRank", each try Number.FromText([rank]) otherwise null),
    #"Changed Type2" = Table.TransformColumnTypes(#"Added Custom4",{{"NumericRank", Int64.Type}}),
    #"Reordered Columns2" = Table.ReorderColumns(#"Changed Type2",{"resultId", "raceId", "driverId", "constructorId", "number", "grid", "position", "positionText", "positionOrder", "points", "laps", "time", "milliseconds", "fastestLap", "rank", "NumericRank", "fastestLapTime", "fastestLapSpeed", "statusId", "PodiumFlag ", "PositionsGained ", "DNF "}),
    #"Removed Columns1" = Table.RemoveColumns(#"Reordered Columns2",{"rank"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns1",{{"NumericRank", "Rank"}}),
    #"Added Custom5" = Table.AddColumn(#"Renamed Columns1", "isFastestLap ", each if [Rank] = 1 then 1 else 0),
    #"Changed Type3" = Table.TransformColumnTypes(#"Added Custom5",{{"isFastestLap ", Int64.Type}, {"PositionsGained ", Int64.Type}, {"DNF ", Int64.Type}, {"position", Int64.Type}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type3", {"raceId"}, Races, {"raceId"}, "Races", JoinKind.Inner),
    #"Expanded Races" = Table.ExpandTableColumn(#"Merged Queries", "Races", {"raceId", "year", "round", "circuitId", "name", "date", "time"}, {"Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name", "Races.date", "Races.time"})
in
    #"Expanded Races"