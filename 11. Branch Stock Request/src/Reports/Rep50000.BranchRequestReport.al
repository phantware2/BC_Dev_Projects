report 50000 "Branch Request Report"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Branch Stock Request Report';
    ApplicationArea = All;
    DefaultRenderingLayout = BranchStockRequestReportRDLC;

    dataset
    {
        dataitem("Stock Request Header"; "Stock Request Header")
        {
            DataItemTableView = sorting("No.", "Store No.") order(ascending);
            RequestFilterFields = "Document Date", "Store No.";
            PrintOnlyIfDetail = true;
            column(No; "No.")
            {
                Caption = 'Stock Request No.';
                IncludeCaption = true;
            }
            column("StoreNo"; "Store No.")
            {
                Caption = 'Requested by Branch';
                IncludeCaption = true;
            }
            column(DocumentDate; "Document Date")
            {
                Caption = 'Date of Request';
                IncludeCaption = true;
            }
            column(ReferenceNo; "Reference No.")
            {
            }
            column(FromStoreNo; "From Store No.")
            {
                Caption = 'Requested to Branch';
                IncludeCaption = true;
            }
            column(NoOfDays; NoOfDays)
            {
            }
            dataitem("Stock Request Line"; "Stock Request Line")
            {
                DataItemLinkReference = "Stock Request Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending);

                column(ItemNo; "Item No.")
                {
                }
                column(Description; Description)
                {
                    Caption = 'Item Description';
                    IncludeCaption = true;
                }
                column(Quantity; abs(Quantity))
                {
                    Caption = 'Requested Quantity';
                }
                column(TotalTransferQty; TotalTransferQty)
                {
                    Caption = 'Processed Quantity';
                }
                column(ProcessedDate; ProcessedDate)
                {
                    Caption = 'Processed Date';
                }
                trigger OnAfterGetRecord()
                var
                    TransferLine: Record "Transfer Shipment Line";
                    StockRequestHeader: Record "Stock Request Header";
                begin
                    clear(TotalTransferQty);
                    StockRequestHeader.Reset();
                    StockRequestHeader.SetRange("No.", "Document No.");
                    if StockRequestHeader.FindFirst() then begin
                        TransferLine.Reset();
                        TransferLine.SetRange("Transfer Order No.", StockRequestHeader."Reference No.");
                        TransferLine.SetRange("Item No.", "Item No.");
                        TransferLine.SetRange("Line No.", "Line No.");
                        if TransferLine.FindFirst() then begin
                            //transfer line field
                            // repeat
                            TotalTransferQty := Abs(TransferLine.Quantity);
                            // until TransferLine.Next() = 0;
                        end;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            var
                StockRequestLine: Record "Stock Request Line";
                TransferHeader: Record "Transfer Shipment Header";
                TransferLine: Record "Transfer Shipment Line";

            begin
                Clear(NoOfDays);
                clear(ProcessedDate);
                // 1. Sum all requested qty for this Stock Request
                TotalRequestedQty := 0;
                TotalTransferQty := 0;

                StockRequestLine.Reset();
                StockRequestLine.SetRange("Document No.", "No.");
                if StockRequestLine.FindSet() then
                    repeat
                        TotalRequestedQty := Abs(StockRequestLine.Quantity);
                    until StockRequestLine.Next() = 0;

                // 2. Sum all shipped qty linked to this Stock Request (via Reference No.)
                TransferHeader.Reset();
                TransferHeader.SetRange("Transfer Order No.", "Reference No.");
                if TransferHeader.FindFirst() then begin
                    ProcessedDate := TransferHeader."Posting Date";
                    TransferLine.Reset();
                    TransferLine.SetRange("Transfer Order No.", "Reference No.");
                    if TransferLine.FindSet() then begin
                        //transfer line field
                        repeat
                            TotalTransferQty := Abs(TransferLine.Quantity);
                        until TransferLine.Next() = 0;
                    end;
                end;

                // 3. Compare quantities
                if TotalRequestedQty = TotalTransferQty then
                    NoOfDays := 'Completed'
                else
                    NoOfDays := Format(Today - "Document Date");
            end;

        }
    }
    rendering
    {
        layout(BranchStockRequestReportRDLC)
        {
            Type = RDLC;
            LayoutFile = './11. Branch Stock Request/src/layouts/BranchStockRequestReport.rdl';
        }
    }
    var
        PostingDate: Date;
        NoOfDays: Text[20];
        TotalRequestedQty: Decimal;
        TotalTransferQty: Decimal;
        ProcessedDate: Date;
}