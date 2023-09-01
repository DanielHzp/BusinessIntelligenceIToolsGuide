
--M code of sample .csv file loaded via Power Query
let
    Source = Folder.Files("C:\Users\Enrolments"),
	
    Navigation1 = Source{0}[Content]
in
    Navigation1
	
	
	
	
--M code of .csv file transformation in Power Query
let
    Source = (Parameter1) => let
	
        Source = Csv.Document(Parameter1,[Delimiter=",", Columns=8, Encoding=1252, QuoteStyle=QuoteStyle.None]),
		
        #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true])
		
    in
	
        #"Promoted Headers"
in

    Source
	
	
	
	
	
	
--M code of Course list query built in Power query
let
    Source = Excel.CurrentWorkbook(){[Name="Table1"]}[Content],
	
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Course Code and Description", type text}, {"Category", type text}, {"Length", type text}}),
	
    #"Split Column by Delimiter" = Table.SplitColumn(#"Changed Type", "Course Code and Description", Splitter.SplitTextByEachDelimiter({" "}, QuoteStyle.Csv, false), {"Course Code and Description.1", "Course Code and Description.2"}),
	
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Course Code and Description.1", Int64.Type}, {"Course Code and Description.2", type text}}),
	
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"Course Code and Description.1", "Course Code"}, {"Course Code and Description.2", "Course Description"}})
	
in

    #"Renamed Columns"
	
	
	



-- M code of Enrolments query built in Power Query
let
    Source = Folder.Files("C:\Users\Enrolments"),
	
    #"Filtered Hidden Files1" = Table.SelectRows(Source, each [Attributes]?[Hidden]? <> true),
	
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
	
    #"Renamed Columns1" = Table.RenameColumns(#"Invoke Custom Function1", {"Name", "Source.Name"}),
	
    #"Removed Other Columns1" = Table.SelectColumns(#"Renamed Columns1", {"Source.Name", "Transform File"}),
	
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
	
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Table Column1",{{"Source.Name", type text}, {"Staff ID", Int64.Type}, {"Staff Name", type text}, {"Email", type text},

	{"Department", type text}, {"Manager", type text}, {"Branch", type text}, {"Course Name", type text}, {"Course Date", type date}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Source.Name"})

	
in


    #"Removed Columns"