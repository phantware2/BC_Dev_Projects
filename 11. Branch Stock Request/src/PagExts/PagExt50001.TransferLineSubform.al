pageextension 50001 TransferLineSubformExt extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Available Qty"; Rec."Available Qty")
            {
                ApplicationArea = All;
            }
            field("STR_ITEM No."; Rec."STR_ITEM No.")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    CurrPage.Update();
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}