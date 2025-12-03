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
            // PrintOnlyIfDetail = true;
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

                dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
                {
                    DataItemLink = "Transfer Order No." = field("Reference No.");
                    DataItemTableView = sorting("No.");
                    DataItemLinkReference = "Stock Request Header";

                    column(TransferNo; "No.")
                    {
                    }
                    column(Posting_Date; "Posting Date")
                    {
                        Caption = 'Processed Date';
                        IncludeCaption = true;
                    }
                    column(Transfer_from_Code; "Transfer-from Code")
                    {
                    }
                    column(Transfer_to_Code; "Transfer-to Code")
                    {
                    }
                    dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemTableView = sorting("Document No.", "Line No.", "Item No.") order(ascending);

                        column(TransferLineItemNo; "Item No.")
                        {
                        }
                        column(TransferLineQuantity; abs(Quantity))
                        {
                            Caption = 'Processed Quantity';
                        }

                        // trigger OnAfterGetRecord()
                        // begin
                        //     Clear(NoOfDays);
                        //     if "Stock Request Line".Quantity = "Transfer Shipment Line".Quantity then
                        //         NoOfDays := 'Completed'
                        //     else
                        //         NoOfDays := Format("Stock Request Header"."Document Date" - Today());
                        // end;
                    }
                }
            }

            trigger OnAfterGetRecord()
            var
                StockRequestLine: Record "Stock Request Line";
                TransferLine: Record "Transfer Shipment Line";
                TotalTransferQty: Decimal;
                TotalRequestedQty: Decimal;
            begin
                Clear(NoOfDays);
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
                TransferLine.Reset();
                TransferLine.SetRange("Transfer Order No.", "Reference No.");
                if TransferLine.FindSet() then
                    repeat
                        TotalTransferQty := Abs(TransferLine.Quantity);
                    until TransferLine.Next() = 0;

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
        // layout(BranchStockRequestReport)
        // {
        //     Type = Excel;
        //     LayoutFile = './11. Branch Stock Request/src/layouts/BranchStockRequestReport.xlsx';
        // }
        layout(BranchStockRequestReportRDLC)
        {
            Type = RDLC;
            LayoutFile = './11. Branch Stock Request/src/layouts/BranchStockRequestReport.rdl';
        }
    }
    var
        PostingDate: Date;
        NoOfDays: Text[20];
}