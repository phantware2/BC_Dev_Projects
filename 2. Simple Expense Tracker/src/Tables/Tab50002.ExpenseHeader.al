table 50101 "Expense Header"
{
    Caption = 'Expense Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." = '' then
                    Error('Expense No. cannot be blank.');
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; "Expense Date"; Date)
        {
            Caption = 'Expense Date';
        }
        field(4; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Expense Line".Amount WHERE("Document No." = FIELD("No.")));
        }
        field(5; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Released,Cancelled;
            OptionCaption = 'Open,"Pending Approval",Released,Cancelled';
        }
        field(6; "Job Title"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Department"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Designation"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Employee Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}