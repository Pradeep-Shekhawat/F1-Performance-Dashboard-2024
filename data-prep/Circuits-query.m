let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\circuits.csv"),[Delimiter=",", Columns=9, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"circuitId", Int64.Type}, {"circuitRef", type text}, {"name", type text}, {"location", type text}, {"country", type text}, {"lat", type number}, {"lng", type number}, {"alt", Int64.Type}, {"url", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"circuitId"}, Races, {"circuitId"}, "Races", JoinKind.Inner),
    #"Expanded Races" = Table.ExpandTableColumn(#"Merged Queries", "Races", {"raceId", "year", "round", "circuitId", "name", "date", "time", "url", "fp1_date", "fp1_time", "fp2_date", "fp2_time", "fp3_date", "fp3_time", "quali_date", "quali_time", "sprint_date", "sprint_time"}, {"Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name", "Races.date", "Races.time", "Races.url", "Races.fp1_date", "Races.fp1_time", "Races.fp2_date", "Races.fp2_time", "Races.fp3_date", "Races.fp3_time", "Races.quali_date", "Races.quali_time", "Races.sprint_date", "Races.sprint_time"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Races",{"url"})
in
    #"Removed Columns"