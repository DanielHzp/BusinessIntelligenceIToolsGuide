
--Insert the following M code in Course List query advanced editor 
let
    Source = Excel.CurrentWorkbook(){[Name="Table1"]}[Content],
	
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Course Code and Description", type text}, {"Category", type text}, {"Length", type text}}),
	
    #"Split Column by Delimiter" = Table.SplitColumn(#"Changed Type", "Course Code and Description", Splitter.SplitTextByEachDelimiter({" "}, QuoteStyle.Csv, false), {"Course Code and Description.1", "Course Code and Description.2"}),
	
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Course Code and Description.1", Int64.Type}, {"Course Code and Description.2", type text}}),
	
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"Course Code and Description.1", "Course Code"}, {"Course Code and Description.2", "Course Description"}})
	
	
in
    #"Renamed Columns"
	
	
	
	




--Insert M code in Course schedule query advanced editor
let


    Source = Excel.Workbook(File.Contents("C:\Users\Training Schedule.xlsx"), null, true),
	
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
	
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
	
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Location", type text}, {"Date", type date}, {"Course Code", Int64.Type}, {"Course Name", type text},

	{"Instructor Code", Int64.Type}, {"Room", type text}}),
	
    #"Filled Down" = Table.FillDown(#"Changed Type",{"Location"})
	
in

    #"Filled Down"










--Insert M code in Staff query advanced editor

let
    Source = Access.Database(File.Contents("C:\Users\Staff.accdb"), [CreateNavigationProperties=true]),
	
    _Staff = Source{[Schema="",Item="Staff"]}[Data],
	
    #"Changed Type" = Table.TransformColumnTypes(_Staff,{{"Start Date", type date}}),
	
    #"Merged Columns" = Table.CombineColumns(#"Changed Type",{"First Name", "Last Name"},Combiner.CombineTextByDelimiter(" ", QuoteStyle.None),"Staff name")
	
	
	
in
    #"Merged Columns"