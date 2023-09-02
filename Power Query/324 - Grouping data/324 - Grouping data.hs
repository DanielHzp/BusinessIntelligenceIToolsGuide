
--Copy and paste in the advanced editor the following M code to execute all data processing steps in the worksheet queries

--M code of Enrolments query built in Power Query Excel

let
    Source = Excel.CurrentWorkbook(){[Name="Enrolments"]}[Content],
	
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Staff ID", Int64.Type}, {"Staff Name", type text}, {"Email", type text}, {"Department", type text}, {"Manager", type text}, {"Branch", type text}, {"Course Name", type text}, {"Days", Int64.Type}, {"Course Start Date", type datetime}}),
	
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","#(00A0)","",Replacer.ReplaceText,{"Department"}),
	
    #"Grouped Rows" = Table.Group(#"Replaced Value", {"Branch", "Department"}, {{"Days training", each List.Sum([Days]), type nullable number}}),
	
    #"Added Custom" = Table.AddColumn(#"Grouped Rows", "June Spend", each [Days training]*550)
	
	
in
    #"Added Custom"