page 50005 "Expense List"
{
    PageType = List;
    SourceTable = "Expense Header";
    UsageCategory = Lists;
    Caption = 'Expense List';
    ApplicationArea = All;
    CardPageId = "Expense Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field("Expense Date"; Rec."Expense Date") { ApplicationArea = All; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
            }
        }
    }
}
