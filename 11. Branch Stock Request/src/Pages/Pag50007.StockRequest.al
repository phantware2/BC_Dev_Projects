page 50007 "Stock Request"
{
    Caption = 'Stock Request';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Stock Request Header";
    SourceTableView = SORTING(Status, "Store No.") WHERE(Status = filter(Open | "Pending Approval"));

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
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
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
            part("Stock Request Subform"; "Stock Request Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group("&Stock Req.")
            {
                Caption = '&Stock Req.';
                action("&Reference Document")
                {
                    Caption = '&Reference Document';
                    Image = Entries;

                    trigger OnAction()
                    var
                        TransferHeader: Record 5740;
                        TransRcptHeader: Record 5746;
                    begin
                        IF TransferHeader.GET(Rec."Reference No.") THEN
                            PAGE.RUN(5740, TransferHeader)
                        ELSE BEGIN
                            TransRcptHeader.RESET();
                            TransRcptHeader.SETCURRENTKEY("Transfer Order No.");
                            TransRcptHeader.SETRANGE("Transfer Order No.", Rec."Reference No.");
                            IF TransRcptHeader.FIND('-') THEN
                                PAGE.RUN(5745, TransRcptHeader);
                        END;
                    END;
                }
                Action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    ToolTip = 'Reopen Branch Request.';
                    Enabled = Rec.Status = Rec.Status::Released;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    begin
                        // UserSetup.get(UserId);
                        // if UserSetup."Branch Request Re-open" = true then begin
                        //     Rec.SetStatusopen();
                        // end
                        // Else begin
                        //     Error('You do not have permission to open Branch Request');
                        // end;
                    end;
                }
                Action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Released Branch Request';
                    Image = ReOpen;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ToolTip = 'Reopen Branch Request.';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        // UserSetup.get(UserId);
                        // if UserSetup."Branch Request Released" = true then begin
                        //     Rec.SetStatusReleased();
                        // end
                        // Else begin
                        //     Error('You do not have permission to release the Branch Request');
                        // end;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Approvals_Process)
            {
                Caption = 'Send for Approval';

                Action(SendforApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    Enabled = Rec.Status = Rec.Status::Open;
                    Promoted = True;
                    PromotedCategory = Process;
                    ToolTip = 'Send for Approval Transfer Order.';

                    trigger OnAction()
                    var
                        StockReqLine: Record "Stock Request Line";
                    begin
                        StockReqLine.Reset();
                        StockReqLine.SetRange("Document No.", Rec."No.");
                        if StockReqLine.IsEmpty then
                            Error('Store Requisition Line Can not be Emty');

                        StockReqLine.Reset();
                        StockReqLine.SetRange("Document No.", Rec."No.");
                        StockReqLine.SetFilter("Item No.", '%1', '');
                        if StockReqLine.FindFirst() then
                            Error('Item No. can not be blank in Store Requisition Line !');

                        if ApprovalMgtExt.CheckBranchStockRequestApprovalsWorkflowEnable(Rec) then
                            ApprovalMgtExt.OnSendBranchStockRequestforApproval(Rec);
                    end;
                }
                Action(CancelforApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel for Approval';
                    Image = CancelApprovalRequest;
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";
                    Promoted = True;
                    PromotedCategory = Process;
                    ToolTip = 'Cancel for Approval Transfer Order.';
                    trigger OnAction()
                    begin
                        ApprovalMgtExt.OnCancelBranchStockRequestforApproval(Rec);
                        Rec.Status := Rec.Status::Open;
                        REc.Modify();
                    end;
                }
            }
            group(Approval)
            {
                action("Approval Entries")
                {
                    ApplicationArea = Suite, Basic;
                    Caption = 'Approval  Entries';
                    Enabled = Rec."No." <> '';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Show the Document for the Approval Entries';
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID);
                    end;
                }
                Action("Approve Document")
                {
                    ApplicationArea = Suite, Basic;
                    Caption = 'Approval';
                    Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Approve the requested changes.';
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite, Basic;
                    Caption = 'Reject';
                    Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Reject the requested changes.';
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite, Basic;
                    Caption = 'Delegate';
                    Enabled = Rec."No." <> '';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Delegate the approval to a substitute approver';
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Dimensions action';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Req. Status" := Rec."Req. Status"::New;
        Rec."Document Type" := Rec."Document Type"::"Transfer Order";
        Rec."In-Transit Code" := 'GIT';
    end;

    var
        UserSetup: Record "User Setup";
        ApprovalMgtExt: Codeunit StockWorkflowTransOrder;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanRequestApprovalForFlow: Boolean;


    trigger OnAfterGetRecord()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

