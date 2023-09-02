
--Copy and paste in the advanced editor the following M code to execute all data processing steps in the worksheet queries

--M code of Budget1 query built in Power Query Excel


let
    Source = Excel.Workbook(File.Contents("C:\Users\Desktop\Training Budget Alt.xlsx"), null, true),
	
    Budget_Table = Source{[Item="Budget",Kind="Table"]}[Data],
	
    #"Split Column by Delimiter" = Table.SplitColumn(Budget_Table, "Cost Centre", Splitter.SplitTextByDelimiter("-", QuoteStyle.Csv), {"Branch", "Department", "Cost Center code"}),
	
    #"Capitalized Each Word" = Table.TransformColumns(#"Split Column by Delimiter",{{"Department", Text.Proper, type text}, {"Branch", Text.Proper, type text}}),
	
    #"Merged Queries" = Table.NestedJoin(#"Capitalized Each Word", {"Branch", "Department"}, Enrolments, {"Branch", "Department"}, "Enrolments", JoinKind.LeftOuter),
	
    #"Expanded Enrolments" = Table.ExpandTableColumn(#"Merged Queries", "Enrolments", {"Jun Spend"}, {"Jun Spend"}),
	
    #"Replaced Value" = Table.ReplaceValue(#"Expanded Enrolments",null,0,Replacer.ReplaceValue,{"Apr Spend", "May Spend", "Jun Spend"}),
	
    #"Added Custom" = Table.AddColumn(#"Replaced Value", "Q2 Spend", each [Apr Spend]+[May Spend]+[Jun Spend]),
	
    #"Added Custom1" = Table.AddColumn(#"Added Custom", "Overbudget", each if [Q2 Spend] > [Quarterly Budget] then "OVER" else null)
	
	
in


    #"Added Custom1"