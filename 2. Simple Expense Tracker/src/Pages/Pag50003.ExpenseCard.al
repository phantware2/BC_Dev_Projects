page 50003 "Expense Card"
{
    PageType = Card;
    SourceTable = "Expense Header";
    Caption = 'Expense Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field("Expense Date"; Rec."Expense Date") { ApplicationArea = All; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
            }

            part(Lines; "Expense Lines Subpage")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
}
