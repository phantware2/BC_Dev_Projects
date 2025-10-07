table 50003 "Expense Line"
{
    Caption = 'Expense Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Expense Category"; Code[20])
        {
            Caption = 'Expense Category';
            TableRelation = "Expense Category".Code;
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Receipt Attached"; Boolean)
        {
            Caption = 'Receipt Attached';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.") { Clustered = true; }
    }



    trigger OnInsert()
    var
        ExpenseHeader: Record "Expense Header";
        ExpenseLine: Record "Expense Line";
    begin
        // Recalculate total amount on header
        ExpenseHeader.Get("Document No.");
        ExpenseLine.SetRange("Document No.", "Document No.");
        ExpenseHeader."Total Amount" := 0;
        if ExpenseLine.FindSet() then
            repeat
                ExpenseHeader."Total Amount" += ExpenseLine.Amount;
            until ExpenseLine.Next() = 0;
        ExpenseHeader.Modify();
    end;
}
