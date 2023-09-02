



--M code of 'Sales OT Yes' query built in Power Query Excel

let
    Source = Table.NestedJoin(#"Sales Staff", {"ID"}, Report, {"Staff ID"}, "Report", JoinKind.Inner),
	
    #"Expanded Report" = Table.ExpandTableColumn(Source, "Report", {"Status"}, {"Status"})
	
in

    #"Expanded Report"
	
	
	
	
--M code of 'Sales OT No' query built in Power Query Excel	
let
    Source = Table.NestedJoin(#"Sales Staff", {"ID"}, Report, {"Staff ID"}, "Report", JoinKind.LeftAnti)
in
    Source