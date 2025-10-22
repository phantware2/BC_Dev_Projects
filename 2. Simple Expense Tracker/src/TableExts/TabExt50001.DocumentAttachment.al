tableextension 50010 DocumentAttachment extends "Document Attachment"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;


    trigger OnBeforeDelete()
    var
        ExpenseLineRecord: Record "Expense Line";
        DocAttc: Record "Document Attachment";
        Count: Integer;
    begin
        case
           Rec."Table ID" of
            Database::"Expense Header":
                begin
                    ExpenseLineRecord.SetRange("Document No.", Rec."No.");
                    DocAttc.SetRange("Table ID", Database::"Expense Header");
                    DocAttc.SetRange("No.", Rec."No.");
                    Count := DocAttc.Count();
                    if Count = 1 then begin
                        if ExpenseLineRecord.FindSet() then begin
                            repeat
                                ExpenseLineRecord."Receipt Attached" := false;
                                ExpenseLineRecord.Modify();
                            until ExpenseLineRecord.Next() = 0;
                        end;
                    end;
                end;
        end;
    end;
}