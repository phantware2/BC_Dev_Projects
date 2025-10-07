codeunit 50000 SendBirthdayGreethings
{
    trigger OnRun()
    begin
        SendBirthdayGreetings();
    end;

    procedure SendBirthdayGreetings()
    var
        EmployeeRec: Record Employees;
        Month: Integer;
        Day: Integer;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        EmployeeRec.SetCurrentKey("Date of Birth");
        EmployeeRec.SetFilter("Date of Birth", '<>%1', 0D);
        If EmployeeRec.FindSet() then
            repeat
                Month := Date2DMY(EmployeeRec."Date of Birth", 2);
                Day := Date2DMY(EmployeeRec."Date of Birth", 1);
                if (Month = Date2DMY(Today(), 2)) and (Day = Date2DMY(Today(), 1)) then begin
                    // Code to send greeting email
                    if EmployeeRec."Email" = '' then
                        Error('Employee does not have an email address.');

                    Subject := 'Greetings from HR';
                    Body := StrSubstNo('Dear %1 %2 %3, %4%4We wish you a day filled with laughter and happiness, and a year ahead that brings you great success! %4%4Best regards,%4%4HR Team',
                     EmployeeRec."First Name", EmployeeRec."Middle Name", EmployeeRec."Last Name", '<br>');

                    EmailMessage.Create(EmployeeRec."Email", Subject, Body, true);
                    If Email.Send(EmailMessage) then
                        Message('Greeting message sent to %1.', EmployeeRec."Full Name")
                    else
                        Message('Failed to send greeting message to %1.', EmployeeRec."Full Name");
                end;
            until EmployeeRec.Next() = 0;
    end;

    var
        myInt: Integer;
}