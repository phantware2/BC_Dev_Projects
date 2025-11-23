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
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                TransferInvtlocationCheck();
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                TransferInvtlocationCheck();
            end;
        }
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            begin
                TransferInvtlocationCheck();
            end;
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


    local procedure TransferInvtlocationCheck()
    begin
        Rec.CalcFields("Available Qty");
        if (Rec."Available Qty" <= 0) then
            Error('In Transfer Order Line with Item No. %1, Inventory is not available for %2.', Rec."Item No.", Rec."Transfer-from Code");
    end;
}