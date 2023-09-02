

--Copy and paste in the advanced editor the following M code to execute all data processing steps in the worksheet queries

--M code of Evals query built in Power Query Excel

let
    Source = Excel.Workbook(File.Contents("C:\Users\Desktop\Course Evaluations Excel Advanced.xlsx"), null, true),
	
    Evals_Sheet = Source{[Item="Evals",Kind="Sheet"]}[Data],
	
    #"Removed Top Rows" = Table.Skip(Evals_Sheet,6),
	
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Top Rows", [PromoteAllScalars=true]),
	
    #"Filled Down" = Table.FillDown(#"Promoted Headers",{"Course"}),
	
    #"Filled Up" = Table.FillUp(#"Filled Down",{"Eval No."}),
	
    #"Filtered Rows" = Table.SelectRows(#"Filled Up", each ([Questions] <> null and [Questions] <> "Questions")),
	
    #"Removed Duplicates" = Table.Distinct(#"Filtered Rows"),
	
    #"Sorted Rows" = Table.Sort(#"Removed Duplicates",{{"Questions", Order.Ascending}, {"Eval No.", Order.Ascending}}),
	
    #"Unpivoted Other Columns" = Table.UnpivotOtherColumns(#"Sorted Rows", {"Course", "Eval No.", "Questions"}, "Rating", "Value"),
	
    #"Removed Columns" = Table.RemoveColumns(#"Unpivoted Other Columns",{"Value"}),
	
    #"Changed Type1" = Table.TransformColumnTypes(#"Removed Columns",{{"Rating", Int64.Type}})
	
	
in

    #"Changed Type1"