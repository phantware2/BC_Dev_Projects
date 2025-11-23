tableextension 50001 TransferLineExt extends "Transfer Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Available Qty"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("Item No."), "Location Code" = field("Transfer-from Code")));
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}