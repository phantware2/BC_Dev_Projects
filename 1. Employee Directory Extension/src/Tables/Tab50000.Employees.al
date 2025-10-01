table 50000 "Employees"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "First Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Middle Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Last Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Email"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Position"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Department"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Hire Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Active"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Designation"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; Addres; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(13; City; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; State; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Zip Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; Country; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Employee ID", Designation, Department)
        {
            Clustered = true;
        }
    }
}