page 50004 "Expense Lines Subpage"
{
    PageType = ListPart;
    SourceTable = "Expense Line";
    Caption = 'Expense Lines';
    AutoSplitKey = true;
    MultipleNewLines = true;
    DelayedInsert = true;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Category"; Rec."Expense Category") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;

                }
                field("Receipt Attached"; Rec."Receipt Attached") { ApplicationArea = All; }
            }
        }
    }
}
