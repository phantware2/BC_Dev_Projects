table 50005 "Stock Request Line"
{
    Caption = 'InStore Stock Req. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            // TableRelation = "InStore Stock Req. Header".No.;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                TempLine: Record "Stock Request Line" temporary;
            begin
                IF (CurrFieldNo <> 0) THEN
                    TestStatusOpen;

                TempLine := Rec;
                INIT;
                "Item No." := TempLine."Item No.";
                IF "Item No." = '' THEN
                    EXIT;

                GetItem;

                Item.TESTFIELD(Blocked, FALSE);

                VALIDATE(Description, Item.Description);
                VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                VALIDATE("Description 2", Item."Description 2");
                VALIDATE(Quantity, xRec.Quantity);
                UpdateLine();
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Requested Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) THEN
                    TestStatusOpen;
                IF Quantity <> 0 THEN
                    TESTFIELD("Item No.");
                "Quantity (Base)" := CalcBaseQty(Quantity);
            end;
        }
        field(5; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) THEN
                    TestStatusOpen;
            end;
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(16; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) THEN
                    TestStatusOpen;
                TESTFIELD("Qty. per Unit of Measure", 1);
                VALIDATE(Quantity, "Quantity (Base)");
            end;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                UnitOfMeasure: Record 204;
                UOMMgt: Codeunit 5402;
            begin
                IF (CurrFieldNo <> 0) THEN
                    TestStatusOpen;
                IF "Unit of Measure Code" = '' THEN
                    "Unit of Measure" := ''
                ELSE BEGIN
                    IF NOT UnitOfMeasure.GET("Unit of Measure Code") THEN
                        UnitOfMeasure.INIT;
                    "Unit of Measure" := UnitOfMeasure.Description;
                END;
                GetItem;
                VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"));
                VALIDATE(Quantity);
            end;
        }
        field(30; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                ItemVariant: Record 5401;
            begin
                IF (CurrFieldNo <> 0) THEN
                    TestStatusOpen;

                IF "Variant Code" = '' THEN
                    EXIT;

                ItemVariant.GET("Item No.", "Variant Code");
                Description := ItemVariant.Description;
                "Description 2" := ItemVariant."Description 2";
            end;
        }
        field(32; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(33; "Allocated Quantity"; Decimal)
        {
            Caption = 'Allocated Quantity';
            trigger OnValidate()
            begin
                if Rec.Quantity < Rec."Allocated Quantity" then
                    Error('you can not enter allocated qty to more than qty.');
            end;
        }
        field(34; "Transfer Quantity"; Decimal)
        {
            Caption = 'Request Quantity';
        }
        field(35; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
        }
        field(36; "Transfer Order Created"; Boolean)
        {
            Caption = 'Transfer Order Created';
        }
        field(118; "Shortcut Dimension 1 Code"; Code[20])
        {

            CaptionClass = '1,2,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                TestStatusOpen;
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(119; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                TestStatusOpen;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }

        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestStatusOpen;
    end;

    trigger OnInsert()
    begin
        TestStatusOpen;
    end;

    trigger OnRename()
    begin
        ERROR(Text001, TABLECAPTION);
    end;

    var
        Header: Record "Stock Request";
        InStoreStockReqLine: Record "Stock Request Line";
        DimMgt: Codeunit DimensionManagement;
        Item: Record 27;
        Text001: Label 'You cannot rename a %1.';

    local procedure GetHeader()
    begin
        TESTFIELD("Document No.");
        IF ("Document No." <> Header."No.") THEN
            Header.GET("Document No.");
    end;

    local procedure GetItem()
    begin
        TESTFIELD("Item No.");
        IF "Item No." <> Item."No." THEN
            Item.GET("Item No.");
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure TestStatusOpen()
    begin
        GetHeader();
        Header.TESTFIELD(Status, Header.Status::Open);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
    begin
        InStoreStockReqLine.RESET;
        InStoreStockReqLine.SETRANGE("Document No.", "Document No.");
        IF InStoreStockReqLine.FINDFIRST THEN;

        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        OldDimSetID := "Dimension Set ID";

        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Document No.", "Line No."));

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        IsChanged := OldDimSetID <> "Dimension Set ID";
    end;

    procedure UpdateLine();
    begin
        InStoreStockReqHeadeRec.RESET;
        IF InStoreStockReqHeadeRec.GET("Document No.") THEN BEGIN
            Rec.Validate("Shortcut Dimension 1 Code", InStoreStockReqHeadeRec."Shortcut Dimension 1 Code");
            ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            Rec.Validate("Shortcut Dimension 2 Code", InStoreStockReqHeadeRec."Shortcut Dimension 2 Code");
            ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        END;
    end;

    var
        InStoreStockReqHeadeRec: Record "Stock Request";
}

