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
        }
        field(5; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Submitted,Approved,Rejected;
            OptionCaption = 'Open,Submitted,Approved,Rejected';
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
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}