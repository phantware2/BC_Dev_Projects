report 50000 "Branch Request Report"
{
    UsageCategory = ReportsAndAnalysis;
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
                    }
                }
            }
        }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Group)
                {
                    field(MyInt; myInt)
                    {
                        ApplicationArea = All;
                        Caption = 'My Integer';
                        ToolTip = 'Enter an integer value.';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
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
        myInt: Integer;
}