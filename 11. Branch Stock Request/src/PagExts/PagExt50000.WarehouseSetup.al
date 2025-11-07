pageextension 50000 WarehouseSetup extends "Warehouse Setup"
{
    layout
    {
        addafter("Whse. Pick Nos.")
        {
            field("Stock Request No."; Rec."Stock Request No.")
            {
                ApplicationArea = All;
            }
        }
    }
}