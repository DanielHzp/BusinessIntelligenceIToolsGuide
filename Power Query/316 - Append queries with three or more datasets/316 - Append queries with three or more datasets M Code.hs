
--Copy and paste in the advanced editor the following M code to execute all data processing in the worksheet queries

--M code to build the Online Training Report query in Power Query Excel
let
    Source = Pdf.Tables(File.Contents("C:\Users\Online Training Report.pdf"), [Implementation="1.1"]),
	
    #"Expanded Data" = Table.ExpandTableColumn(Source, "Data", {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9"}, {"Data.Column1", "Data.Column2", "Data.Column3", "Data.Column4", "Data.Column5", "Data.Column6", "Data.Column7", "Data.Column8", "Data.Column9"})
in

    #"Expanded Data"