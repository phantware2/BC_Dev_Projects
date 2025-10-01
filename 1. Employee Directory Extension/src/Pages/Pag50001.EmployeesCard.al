page 50001 "Employees Card"
{
    PageType = Card;
    SourceTable = "Employees";
    Caption = 'Employees Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee ID"; Rec."Employee ID") { ApplicationArea = All; }
                field("First Name"; Rec."First Name") { ApplicationArea = All; }
                field("Middle Name"; Rec."Middle Name") { ApplicationArea = All; }
                field("Last Name"; Rec."Last Name") { ApplicationArea = All; }
                field("Full Name"; Rec."Full Name") { ApplicationArea = All; }
                field("Date of Birth"; Rec."Date of Birth") { ApplicationArea = All; }
                field("Gender"; Rec."Gender") { ApplicationArea = All; }
            }
            group(Contact)
            {
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Email"; Rec."Email") { ApplicationArea = All; }
                field(Address; Rec.Address) { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Zip Code"; Rec."Zip Code") { ApplicationArea = All; }
                field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = All; }
            }
            group(Employment)
            {
                field("Position"; Rec.Position) { ApplicationArea = All; }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; }
                field("Department"; Rec."Department") { ApplicationArea = All; }
                field("Hire Date"; Rec."Hire Date") { ApplicationArea = All; }
                field("Active"; Rec."Active") { ApplicationArea = All; }
                field("Designation"; Rec."Designation") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // Add actions if needed
        }
    }
}