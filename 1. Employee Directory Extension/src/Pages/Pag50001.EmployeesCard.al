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
                field(Age; Rec.Age) { ApplicationArea = All; Editable = false; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // Add actions if needed
            action(SendGreeting)
            {
                ApplicationArea = All;
                Caption = 'Send Greeting';
                Image = SendMail;
                trigger OnAction()
                var
                    EmailMessage: Codeunit "Email Message";
                    Email: Codeunit Email;
                    Subject: Text;
                    Body: Text;
                begin
                    if Rec."Email" = '' then
                        Error('Employee does not have an email address.');

                    Subject := 'Greetings from HR';
                    Body := StrSubstNo('Dear %1 %2,%3%3We wish you a wonderful day!%3%3Best regards,%3HR Team',
                     Rec."First Name", Rec."Last Name", '<br>');

                    EmailMessage.Create(Rec."Email", Subject, Body, true);
                    Email.Send(EmailMessage);
                    Message('Greeting message sent to %1.', Rec."Full Name");
                end;
            }
        }
    }
}