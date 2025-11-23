page 50010 "Approved Stock Request"
{
    Caption = 'Approved Stock Request';
    PageType = Document;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Stock Request Header";
    SourceTableView = SORTING(Status, "Store No.") WHERE(Status = CONST(Released));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Req. Status"; Rec."Req. Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                    visible = false;
                }
                field("Reference Type"; Rec."Reference Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                    visible = false;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ValuesAllowed = "Transfer Order";
                    ApplicationArea = All;
                    visible = false;
                }
                field("From Store No."; Rec."From Store No.")
                {
                    ApplicationArea = All;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ticket No."; Rec."Ticket No.")
                {
                    ApplicationArea = All;
                }
            }
            part(RequestSubformReleased; "Approved Stock Request Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Reference Document")
            {
                Caption = '&Reference Document';
                Image = Entries;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TransferHeader: Record 5740;
                    TransRcptHeader: Record "Transfer Header";
                begin

                    TransRcptHeader.RESET();
                    TransRcptHeader.SETCURRENTKEY("No.");
                    TransRcptHeader.SETRANGE("No.", Rec."Reference No.");
                    IF TransRcptHeader.FIND('-') THEN
                        PAGE.RUN(5740, TransRcptHeader);
                END;
            }
            action(CreateTransferOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Transfer Order';
                trigger OnAction()
                var
                    InStoreStockReqMgt: Codeunit "Store Stock Req Mgt";
                begin
                    if not Confirm('Do you want to Create Transfer Order!', false, true) then
                        exit;

                    //Rec.TestField("Req. Status", Rec."Req. Status"::New);
                    InStoreStockReqMgt.CreateTransferOrder(Rec);
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = All;
                ToolTip = 'Executes the Dimensions action';
                trigger OnAction();
                begin
                    Rec.ShowDocDim();
                    CurrPage.SaveRecord();
                end;
            }
        }
        area(Promoted)
        {
            actionref(CreateTransferOrder_ref; CreateTransferOrder)
            {

            }
            actionref("Reference Document_Ref"; "&Reference Document")
            {

            }
            actionref(Dimensions_ref; Dimensions)
            { }
        }
    }
}

