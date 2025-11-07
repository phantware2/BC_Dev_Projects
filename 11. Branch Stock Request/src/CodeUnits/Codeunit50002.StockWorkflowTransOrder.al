codeunit 50002 "StockWorkflowTransOrder"
{

    trigger OnRun()
    begin
    end;
    // Approval Mgmt. for Integration Event ****ST****
    [IntegrationEvent(false, false)]
    procedure OnSendBranchStockRequestforApproval(Var InstoreHeader: Record "Stock Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelBranchStockRequestforApproval(Var InstoreHeader: Record "Stock Request Header")

    var
    begin
    end;

    procedure CheckBranchStockRequestApprovalsWorkflowEnable(Var InstoreHeader: Record "Stock Request Header"): Boolean
    var
        Vendor: Record Vendor;
    begin
        if NOT IsBranchStockRequestDocApprovalsWorkflowEnable(InstoreHeader) then
            Error('No approval workflow for this record type is enabled');
        exit(true)
    end;

    // procedure CheckProductionOrderApprovalWorkflowEnabledValidate(var ProductionOrder: Record "InStore Stock Req. Header"): Boolean;
    // var
    //     WorkflowManagement: Codeunit "Workflow Management";
    //     CheckWorkFlowEnable: Boolean;
    // begin
    //     CheckWorkFlowEnable := WorkflowManagement.CanExecuteWorkflow(ProductionOrder, RunWorkflowOnSendBranchStockRequestForApprovalCode());
    //     exit(CheckWorkFlowEnable);
    // end;

    procedure RunWorkflowOnSendBranchStockRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBranchStockRequestForApprovalCode'))
    end;

    procedure IsBranchStockRequestDocApprovalsWorkflowEnable(Var InstoreHeader: Record "Stock Request Header"): Boolean
    var
        WorkFlowmanagement: Codeunit "Workflow Management";
    begin
        if InstoreHeader.Status <> InstoreHeader.Status::Open then
            exit(false);
        exit(WorkFlowmanagement.CanExecuteWorkflow(InstoreHeader, RunWorkflowOnSendBranchStockRequestForApprovalCode));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        InstoreHeader: Record "Stock Request Header";
    begin
        case RecRef.Number of
            Database::"Stock Request Header":
                begin
                    RecRef.SetTable((InstoreHeader));
                    ApprovalEntryArgument."Document No." := InstoreHeader."No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"StockWorkflowTransOrder", 'OnSendBranchStockRequestforApproval', '', true, true)]
    local procedure RunWorkflowOnSendBranchStockRequestForApproval(Var InstoreHeader: Record "Stock Request Header")
    var
        WorkFlowmanagement: Codeunit "Workflow Management";
    begin
        WorkFlowmanagement.HandleEvent(RunWorkflowOnSendBranchStockRequestForApprovalCode, InstoreHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"StockWorkflowTransOrder", 'OnCancelBranchStockRequestforApproval', '', true, true)]
    local procedure RunWorkflowOnCancelBranchStockRequestApproval(Var InstoreHeader: Record "Stock Request Header")
    var
        WorkFlowmanagement: Codeunit "Workflow Management";
    //InstoreHeader: Record "InStore Stock Req. Header";
    begin
        WorkFlowmanagement.HandleEvent(RunWorkflowOnCancelBranchStockRequestApprovalCode, InstoreHeader);

        InstoreHeader.Status := InstoreHeader.Status::Open;
        InstoreHeader.Modify;
    end;

    procedure RunWorkflowOnCancelBranchStockRequestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBranchStockRequestApprovalCode'))
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkFlowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendBranchStockRequestForApprovalCode, Database::"Stock Request Header", 'Approval of Branch Stock Request is requested', 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBranchStockRequestApprovalCode, Database::"Stock Request Header", 'Approval of Branch Stock Request is canceled', 0, false);



    end;

    // WorkFlow Response Handling Eventsubscriber ****ST****
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef;
    var Handled: Boolean)
    var
        InstoreHeader: Record "Stock Request Header";
        InstoreHeader1: Record "Stock Request Header";
    begin
        case RecRef.Number of
            Database::"Stock Request Header":
                begin
                    RecRef.SetTable(InstoreHeader);
                    InstoreHeader1.Reset();
                    InstoreHeader1.SetRange(Status, InstoreHeader.Status::Released);
                    InstoreHeader1.SetRange("No.", InstoreHeader."No.");
                    if InstoreHeader1.FindFirst() then begin
                        InstoreHeader1.Status := InstoreHeader1.Status::Open;
                        InstoreHeader1.Modify;
                    end;
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        InstoreHeader: Record "Stock Request Header";
        InstoreHeader1: Record "Stock Request Header";
    begin
        case RecRef.Number of
            Database::"Stock Request Header":
                begin
                    RecRef.SetTable(InstoreHeader);
                    InstoreHeader1.Reset();
                    InstoreHeader1.SetRange("No.", InstoreHeader."No.");
                    if InstoreHeader1.FindFirst() then begin
                        InstoreHeader1.Status := InstoreHeader1.Status::Released;
                        InstoreHeader1.Modify;
                    end;
                    Handled := true;
                end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        InstoreHeader: Record "Stock Request Header";
        InstoreHeader1: Record "Stock Request Header";
    begin
        case RecRef.Number of
            Database::"Stock Request Header":
                begin
                    RecRef.SetTable(InstoreHeader);
                    InstoreHeader1.Reset();
                    InstoreHeader1.SetRange("No.", InstoreHeader."No.");
                    if InstoreHeader1.FindFirst() then begin
                        InstoreHeader1.Status := InstoreHeader1.Status::"Pending Approval";
                        InstoreHeader1.Modify;
                    end;
                    IsHandled := true;
                end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
        Workflowsetup: Codeunit "Workflow Setup";
    begin
        Workflowsetup.InsertTableRelation(Database::"Stock Request Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));

    end;

    local procedure InsertBranchStockRequestApprovalworkflowdetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateformula: DateFormula;
        WorkflowEventHandlingCust: Codeunit "StockWorkflowTransOrder";
        WorkflowResposeHandling: Codeunit "Workflow Response Handling";
        InstoreHeader: Record "Stock Request Header";
        Workflowsetup: Codeunit "Workflow Setup";
    begin
        Workflowsetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateformula, true);
        Workflowsetup.InsertDocApprovalWorkflowSteps(Workflow, BuildBranchStockRequesttypeCondition(0), WorkflowEventHandlingCust.RunWorkflowOnSendBranchStockRequestForApprovalCode, BuildBranchStockRequesttypeCondition(2), WorkflowEventHandlingCust.RunWorkflowOnCancelBranchStockRequestApprovalCode, WorkflowStepArgument, true);
        //0-Open status
        //2-Pending approval status
    end;

    local procedure BuildBranchStockRequesttypeCondition(Status: Integer): Text
    Var
        BudgetHeaerRec: Record "Stock Request Header";
        Workflowsetup: Codeunit "Workflow Setup";
        VouchertypeCondinText: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Voucher Header">%1</DataItem></DataItems></ReportParameters>';
    begin
        BudgetHeaerRec.SetRange(BudgetHeaerRec.Status, Status);
        Exit(StrSubstNo(VouchertypeCondinText, Workflowsetup.Encode(BudgetHeaerRec.GetView(false))));
    end;

    // local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    // var
    // begin

    //     case RecordRef.Number of
    //         Database::"Stock Request Header":
    //             EXIT(GetProductionBOMHeaderPageID(RecordRef));


    //     end;
    // end;

    // local procedure GetProductionBOMHeaderPageID(RecordRef: RecordRef): Integer
    // var
    //     ProductionBOMHeader: Record "InStore Stock Req. Header";
    // begin
    //     RecordRef.SETTABLE(ProductionBOMHeader);
    //     EXIT(PAGE::"Production BOM");
    // end;

    // [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    // local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    // var
    //     ApprovalEntry1: Record "Approval Entry";
    //     Rec_ProductionBOMHeader: Record "InStore Stock Req. Header";
    // begin
    //     if ApprovalEntry."Table ID" = Database::"InStore Stock Req. Header" then begin
    //         ApprovalEntry1.reset;
    //         ApprovalEntry1.setrange(ApprovalEntry1."Document No.", ApprovalEntry."Document No.");
    //         if ApprovalEntry1.FindLast then begin
    //             if ApprovalEntry."Entry No." = ApprovalEntry1."Entry No." then begin
    //                 if Rec_ProductionBOMHeader.get(ApprovalEntry1."Document No.") then begin
    //                     Rec_ProductionBOMHeader.Status := Rec_ProductionBOMHeader.Status::Released;
    //                     Rec_ProductionBOMHeader.Modify;
    //                 end;
    //             end;
    //         end;
    //     end;


    // end;

    // [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Approvals Mgmt.", 'OnAfterRejectSelectedApprovalRequest', '', true, true)]
    // local procedure OnAfterRejectSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    // var
    //     Rec_ProductionBOMHeader: Record "InStore Stock Req. Header";
    // begin

    //     if ApprovalEntry."Table ID" = Database::"InStore Stock Req. Header" then begin
    //         Rec_ProductionBOMHeader.reset;
    //         if Rec_ProductionBOMHeader.get(ApprovalEntry."Document No.") then begin
    //             Rec_ProductionBOMHeader.Status := Rec_ProductionBOMHeader.Status::Open;
    //             Rec_ProductionBOMHeader.Modify;
    //         end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Approvals Mgmt.", 'OnAfterPopulateApprovalEntryArgument', '', true, true)]
    // local procedure OnAfterPopulateApprovalEntryArgument(WorkflowStepInstance: Record "Workflow Step Instance"; var ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean; var RecRef: RecordRef)
    // var
    //     Rec_ProductionBOMHeader: Record "InStore Stock Req. Header";
    // begin
    //     case RecRef.Number of
    //         Database::"InStore Stock Req. Header":
    //             begin
    //                 RecRef.SetTable((Rec_ProductionBOMHeader));
    //                 ApprovalEntryArgument."Document No." := Rec_ProductionBOMHeader."No.";
    //             end;
    //     end;
    // end;
}