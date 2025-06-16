let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\pit_stops.csv"),[Delimiter=",", Columns=7, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"raceId", Int64.Type}, {"driverId", Int64.Type}, {"stop", Int64.Type}, {"lap", Int64.Type}, {"time", type time}, {"duration", type text}, {"milliseconds", Int64.Type}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"raceId"}, Races, {"raceId"}, "Races", JoinKind.Inner),
    #"Expanded Races" = Table.ExpandTableColumn(#"Merged Queries", "Races", {"raceId", "year", "round", "circuitId", "name"}, {"Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name"})
in
    #"Expanded Races"