page 50002 "Expense Categories"
{
    PageType = List;
    SourceTable = "Expense Category";
    Caption = 'Expense Categories';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
                field("GL Account No."; Rec."GL Account No.") { ApplicationArea = All; }
            }
        }
    }
}
