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
        field(50001; "STR_ITEM No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item" where(Blocked = const(false), "Global Dimension 1 Code" = field("Shortcut Dimension 1 Code"), "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"), "Sales Blocked" = const(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ItemRec: Record Item;
                TransferHeaderRec: Record "Transfer Header";
            begin
                TransferHeaderRec.Reset();
                TransferHeaderRec.SetRange("No.", Rec."Document No.");
                TransferHeaderRec.FindSet();
                TransferHeaderRec.TestField("Transfer-from Code");
                TransferHeaderRec.TestField("Transfer-to Code");
                TransferHeaderRec.TestField("In-Transit Code");
                TransferHeaderRec.TestField("Shortcut Dimension 1 Code");
                TransferHeaderRec.TestField("Shortcut Dimension 2 Code");
                if ("STR_ITEM No." <> '') then begin
                    Rec.Validate("Item No.", "STR_ITEM No.");
                    if ItemRec.Get("STR_ITEM No.") then begin
                        Description := ItemRec.Description;
                        "Description 2" := ItemRec."Description 2";
                    end;
                end;
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

    var
        myInt: Integer;
}