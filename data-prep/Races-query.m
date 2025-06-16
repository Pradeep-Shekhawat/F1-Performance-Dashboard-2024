let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\races.csv"),[Delimiter=",", Columns=18, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"raceId", Int64.Type}, {"year", Int64.Type}, {"round", Int64.Type}, {"circuitId", Int64.Type}, {"name", type text}, {"date", type date}, {"time", type text}, {"url", type text}, {"fp1_date", type text}, {"fp1_time", type text}, {"fp2_date", type text}, {"fp2_time", type text}, {"fp3_date", type text}, {"fp3_time", type text}, {"quali_date", type text}, {"quali_time", type text}, {"sprint_date", type text}, {"sprint_time", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"year"}, Seasons, {"year"}, "Seasons", JoinKind.Inner),
    #"Removed Columns" = Table.RemoveColumns(#"Merged Queries",{"url"})
in
    #"Removed Columns"