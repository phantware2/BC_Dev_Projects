report 50000 "Branch Request"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = BranchStockRequestReport;

    dataset
    {
        dataitem("Stock Request Header"; "Stock Request Header")
        {
            dataitemtableview = sorting("No.");
            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(StoreNo; "Store No.")
            {
                IncludeCaption = true;
            }
            column(DocumentDate; "Document Date")
            {
                IncludeCaption = true;
            }
            column(ReferenceNo; "Reference No.")
            {
                IncludeCaption = true;
            }
            column(FromStoreNo; "From Store No.")
            {
                IncludeCaption = true;
            }
            dataitem("Stock Request Line"; "Stock Request Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Line No.");

                column(ItemNo; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Transfer Header"; "Transfer Header")
            {
                DataItemLink = "No." = field("Reference No.");
                DataItemTableView = sorting("No.");

                column(TransferNo; "No.")
                {
                    IncludeCaption = true;
                }
                column(Transfer_from_Code; "Transfer-from Code")
                {
                    IncludeCaption = true;
                }
                column(Transfer_to_Code; "Transfer-to Code")
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Line No.");

                column(TransferLineItemNo; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(TransferLineQuantity; Quantity)
                {
                    IncludeCaption = true;
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
            LayoutFile = 'BranchStockRequestReport.xlsx';
        }
    }

    var
        myInt: Integer;
}