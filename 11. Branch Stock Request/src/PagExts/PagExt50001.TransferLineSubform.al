pageextension 50001 TransferLineSubformExt extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Available Qty"; Rec."Available Qty")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}