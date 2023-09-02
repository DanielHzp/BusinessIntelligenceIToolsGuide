
--Copy and paste in the advanced editor the following M code to execute all data processing steps in the worksheet queries

--M code of Evals query built in Power Query Excel

let
    Source = Excel.Workbook(File.Contents("C:\Desktop\Course Evaluations MS Project.xlsx"), null, true),
	
    Evals_Sheet = Source{[Item="Evals",Kind="Sheet"]}[Data],
	
    #"Removed Top Rows" = Table.Skip(Evals_Sheet,6),
	
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Top Rows", [PromoteAllScalars=true]),
	
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Course", type text}, {"Eval No.", type any}, {"Questions", type text}, {"5", type any}, {"4", type any}, {"3", type any}, {"2", type any}, {"1", Int64.Type}}),
	
    #"Filled Down" = Table.FillDown(#"Changed Type",{"Course"}),
	
    #"Filled Up" = Table.FillUp(#"Filled Down",{"Eval No."}),
	
    #"Filtered Rows" = Table.SelectRows(#"Filled Up", each ([Questions] <> null and [Questions] <> "Questions")),
	
    #"Removed Duplicates" = Table.Distinct(#"Filtered Rows"),
	
    #"Sorted Rows" = Table.Sort(#"Removed Duplicates",{{"Questions", Order.Ascending}, {"Eval No.", Order.Ascending}})
	
in


    #"Sorted Rows"