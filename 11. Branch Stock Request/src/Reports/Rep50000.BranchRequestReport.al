report 50000 "Branch Request Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = BranchStockRequestReport;

    dataset
    {
        dataitem("Stock Request Header"; "Stock Request Header")
        {
            DataItemTableView = sorting("No.", "Store No.") order(ascending);
            RequestFilterFields = "Document Date", "Store No.";
            PrintOnlyIfDetail = true;
            column(No; "No.")
            {
            }
            column(StoreNo; "Store No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(ReferenceNo; "Reference No.")
            {
            }
            column(FromStoreNo; "From Store No.")
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
                }
                column(Quantity; Quantity)
                {
                }
            }
            dataitem("Transfer Header"; "Transfer Header")
            {
                DataItemLink = "No." = field("Reference No.");
                DataItemTableView = sorting("No.");

                column(TransferNo; "No.")
                {
                }
                column(Transfer_from_Code; "Transfer-from Code")
                {
                }
                column(Transfer_to_Code; "Transfer-to Code")
                {
                }
                dataitem("Transfer Line"; "Transfer Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.", "Item No.") order(ascending);

                    column(TransferLineItemNo; "Item No.")
                    {
                    }
                    column(TransferLineQuantity; Quantity)
                    {
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
        layout(BranchStockRequestReport)
        {
            Type = Excel;
            LayoutFile = './11. Branch Stock Request/src/layouts/BranchStockRequestReport.xlsx';
        }
    }

    var
        myInt: Integer;
}