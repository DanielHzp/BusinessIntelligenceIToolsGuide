
--Copy and paste in the advanced editor the following M code to execute all data processing in the worksheet queries

--M code of Instructors_Sydney query built in Power Query Excel
let
    Source = Excel.CurrentWorkbook(){[Name="Instructors_Sydney"]}[Content],
	
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Instructor ID", Int64.Type}, {"Instructor Name", type text}}),
	
    #"Added Custom" = Table.AddColumn(#"Changed Type", "Location", each "Sydney")
	
in

    #"Added Custom"
	
	
	
--M code of Instructors_Other8 query built in Power Query Excel
let
    Source = Excel.CurrentWorkbook(){[Name="Instructors_Other8"]}[Content],
	
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Instructor Name", type text}, {"Instructor ID", Int64.Type}, {"Location", type text}})
in
    #"Changed Type"
	
	
	
	
--M code of Instructors_all query built in Power Query Excel
let
    Source = Table.Combine({Instructors_Sydney, Instructors_Other8})
	
in

    Source
	
	