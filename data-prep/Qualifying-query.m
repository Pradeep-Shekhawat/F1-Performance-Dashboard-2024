let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\qualifying.csv"),[Delimiter=",", Columns=9, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"qualifyId", Int64.Type}, {"raceId", Int64.Type}, {"driverId", Int64.Type}, {"constructorId", Int64.Type}, {"number", Int64.Type}, {"position", Int64.Type}, {"q1", type text}, {"q2", type text}, {"q3", type text}}),
    #"Added Custom" = Table.AddColumn(
    #"Changed Type",
    "Q_Status",
    each 
      if [q3] <> null and [q3] <> "\N" then "Made Q3"
      else if [q2] <> null and [q2] <> "\N" then "Made Q2"
      else "Eliminated Q1"
),
    #"Merged Queries" = Table.NestedJoin(#"Added Custom", {"raceId"}, Races, {"raceId"}, "Races", JoinKind.Inner),
    #"Expanded Races" = Table.ExpandTableColumn(#"Merged Queries", "Races", {"raceId", "year", "round", "circuitId", "name", "quali_date", "quali_time"}, {"Races.raceId", "Races.year", "Races.round", "Races.circuitId", "Races.name", "Races.quali_date", "Races.quali_time"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Expanded Races",{{"Q_Status", type text}})
in
    #"Changed Type1"