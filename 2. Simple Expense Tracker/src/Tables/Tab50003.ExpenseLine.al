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
            Editable = false;
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
        LastLine: Record "Expense Line";
    begin
        if "Line No." = 0 then begin
            LastLine.Reset();
            LastLine.SetRange("Document No.", "Document No.");
            if LastLine.FindLast() then
                "Line No." := LastLine."Line No." + 10000
            else
                "Line No." := 10000;
        end;

        if ExpenseHeader.Get("Document No.") then begin
            RecalculateTotalAmount();
        end;
    end;

    trigger OnModify()
    begin
        if ExpenseHeader.Get("Document No.") then begin
            RecalculateTotalAmount();
        end;
    end;

    trigger OnDelete()
    begin
        if ExpenseHeader.Get("Document No.") then begin
            RecalculateTotalAmount();
        end;
    end;

    procedure RecalculateTotalAmount()
    begin
        // Recalculate total amount on header
        ExpenseHeader.Get("Document No.");
        ExpenseLine.SetRange("Document No.", "Document No.");
        ExpenseHeader."Total Amount" := 0;
        if ExpenseLine.FindSet() then
            repeat
                ExpenseHeader."Total Amount" += ExpenseLine.Amount;
            until ExpenseLine.Next() = 0;

        ExpenseHeader.Modify(true);
    end;




    // trigger OnInsert()
    // var
    //     ExpenseHeader: Record "Expense Header";
    //     ExpenseLine: Record "Expense Line";
    // begin
    //     // Recalculate total amount on header
    //     ExpenseHeader.Get("Document No.");
    //     ExpenseLine.SetRange("Document No.", "Document No.");
    //     ExpenseHeader."Total Amount" := 0;
    //     if ExpenseLine.FindSet() then
    //         repeat
    //             ExpenseHeader."Total Amount" += ExpenseLine.Amount;
    //         until ExpenseLine.Next() = 0;
    //     ExpenseHeader.Modify();
    // end;
    var
        ExpenseHeader: Record "Expense Header";
        ExpenseLine: Record "Expense Line";
}
