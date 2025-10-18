page 50003 "Expense Card"
{
    PageType = Card;
    SourceTable = "Expense Header";
    Caption = 'Expense Card';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field("Employee Name"; Rec."Employee Name") { ApplicationArea = All; }
                field("Expense Date"; Rec."Expense Date") { ApplicationArea = All; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
                field(Department; Rec.Department) { ApplicationArea = All; }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; }
                field(Designation; Rec.Designation) { ApplicationArea = All; }
            }
            part(Lines; "Expense Lines Subpage")
            {
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            // part(ExpenseStatistics; "Expense Statistics FactBox")
            // {
            //     ApplicationArea = All;
            // }
            // part(ApprovalStatus; "Approval Status FactBox")
            // {
            //     ApplicationArea = All;
            // }
            part(Attachments; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
            }
            part(EmailAttachments; "Email Attachments")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        ExpenseLine: Record "Expense Line";
    begin
        if Rec."No." <> '' then begin
            if Rec.Status = Rec.Status::Open then begin
                // Delete associated expense lines
                if Confirm('Are you sure you want to delete this document?', true) then begin
                    ExpenseLine.SetRange("Document No.", Rec."No.");
                    if ExpenseLine.FindSet() then
                        ExpenseLine.DeleteAll();
                end
                else begin
                    Message('Delete operation cancelled.');
                    exit(false);
                end;
            end
            else begin
                Message('Only documents with status "Open" can be deleted.');
                exit(false);
            end;
        end;
    end;
}
