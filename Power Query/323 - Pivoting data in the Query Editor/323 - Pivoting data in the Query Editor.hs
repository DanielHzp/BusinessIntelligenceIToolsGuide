

--Copy and paste in the advanced editor the following M code to execute all data processing steps in the worksheet queries

--M code of Room_Facilities query built in Power Query Excel

let
    Source = Excel.CurrentWorkbook(){[Name="Room_Facilities"]}[Content],
	
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Location", type text}, {"Room", type text}, {"Facility", type text}, {"Available", type any}}),
	
    #"Pivoted Column" = Table.Pivot(#"Changed Type", List.Distinct(#"Changed Type"[Facility]), "Facility", "Available")
	
	
in
    #"Pivoted Column"