

--M code of TrainingScheduleLEFTJOINED query built in Power Query Excel
let
    Source = Excel.Workbook(File.Contents("C:\Users\Training Schedule.xlsx"), null, true),
	
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
	
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
	
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Location", type text}, {"Date", type date}, {"Course Code", Int64.Type}, {"Course Name", type text}, {"Instructor Code", Int64.Type}, {"Room", type text}}),
	
    #"Filled Down" = Table.FillDown(#"Changed Type",{"Location"}),
	
    #"Filled Up" = Table.FillUp(#"Filled Down",{"Location"}),
	
    #"Merged Queries" = Table.NestedJoin(#"Filled Up", {"Instructor Code"}, Instructors_All, {"Instructor ID"}, "Instructors_All", JoinKind.LeftOuter),
	
    #"Expanded Instructors_All" = Table.ExpandTableColumn(#"Merged Queries", "Instructors_All", {"Instructor Name"}, {"Instructor Name"})
	
in

    #"Expanded Instructors_All"