let
    Source = Csv.Document(File.Contents("C:\Project\Data Analytics\Data\seasons.csv"),[Delimiter=",", Columns=2, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"year", Int64.Type}, {"url", type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([year] = 2024)),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows",{"url"})
in
    #"Removed Columns"