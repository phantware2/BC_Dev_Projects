table 50004 "Stock Request Header"
{
    Caption = 'Stock Request Header';
    LookupPageID = "Stock Request List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Store No."; Code[10])
        {
            Caption = 'Request Location';
            TableRelation = Location.Code;
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(4; Status; Enum "Sales Document Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(5; "Req. Status"; Option)
        {
            Caption = 'Req. Status';
            OptionCaption = 'New,Sent,Accepted,Declined';
            OptionMembers = New,Sent,Accepted,Declined;
        }
        field(6; "Reference Type"; Option)
        {
            Caption = 'Reference Type';
            OptionCaption = ' ,Transfer,Purchase,Replenishment';
            OptionMembers = " ",Transfer,Purchase,Replenishment;
        }
        field(7; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
        }
        field(8; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Purchase Order,Transfer Order';
            OptionMembers = "Purchase Order","Transfer Order";

            trigger OnValidate()
            begin
                TestStatusOpen();
                TESTFIELD("Req. Status", "Req. Status"::New);
                VALIDATE("Process Type", "Process Type"::Create);
            end;
        }
        field(9; "Process Type"; Option)
        {
            Caption = 'Process Type';
            OptionCaption = 'Create,Replenish';
            OptionMembers = Create,Replenish;

            trigger OnValidate()
            begin
                TestStatusOpen();
                TESTFIELD("Req. Status", "Req. Status"::New);
                "Vendor No." := '';
                "From Store No." := '';
                "In-Transit Code" := '';
                "Plan.Stock Demand Type" := "Plan.Stock Demand Type"::" ";
                "Plan.Stock Demand Type" := "Plan.Stock Demand Type"::"Transfer Order";
            end;
        }
        field(10; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                TestStatusOpen();
                TESTFIELD("Req. Status", "Req. Status"::New);
                TESTFIELD("Document Type", "Document Type"::"Purchase Order");
                TESTFIELD("Process Type", "Process Type"::Create);
                "From Store No." := '';
                "In-Transit Code" := '';
                "Plan.Stock Demand Type" := "Plan.Stock Demand Type"::" ";
            end;
        }
        field(11; "From Store No."; Code[20])
        {
            Caption = 'From Store Location';
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                TestStatusOpen();
                TESTFIELD("Req. Status", "Req. Status"::New);
                TESTFIELD("Document Type", "Document Type"::"Transfer Order");
                TESTFIELD("Process Type", "Process Type"::Create);
                "Vendor No." := '';
                "Plan.Stock Demand Type" := "Plan.Stock Demand Type"::" ";
            end;
        }
        field(12; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Req. Status", "Req. Status"::New);
                TESTFIELD("Document Type", "Document Type"::"Transfer Order");
                TESTFIELD("Process Type", "Process Type"::Create);
                "Vendor No." := '';
                "Plan.Stock Demand Type" := "Plan.Stock Demand Type"::" ";
            end;
        }
        field(13; "Plan.Stock Demand Type"; Option)
        {
            Caption = 'Plan.Stock Demand Type';
            OptionCaption = ' ,Transfer Order,PO to Store,PO to Whse w/X-Dock';
            OptionMembers = " ","Transfer Order","PO to Store","PO to Whse w/X-Dock";

            trigger OnValidate()
            begin
                TestStatusOpen();
                TESTFIELD("Req. Status", "Req. Status"::New);
                TESTFIELD("Process Type", "Process Type"::Replenish);
                "Vendor No." := '';
                "From Store No." := '';
                "In-Transit Code" := '';
            end;
        }
        field(14; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Requisition Division';
            CaptionClass = '1,2,1';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin

                TestStatusOpen;
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Requisition Department';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                TestStatusOpen;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                RecCustomer: Record Customer;
            begin
                if RecCustomer.get("Customer No.") then
                    "Customer Name" := RecCustomer.Name
                else
                    "Customer Name" := '';

            end;
        }
        field(18; "Customer Name"; Text[100])
        {
        }
        field(19; "Ticket No."; code[50])
        {
        }
        field(20; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Store No.")
        {
        }
        key(Key3; Status, "Store No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        StockReqLine: Record "Stock Request Line";
    begin
        TestStatusOpen();

        StockReqLine.SETRANGE(StockReqLine."Document No.", "No.");
        StockReqLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        WarehouseSetup.GET();
        IF "No." = '' THEN BEGIN
            WarehouseSetup.TESTFIELD(WarehouseSetup."Stock Request No.");
            "No." := NoSeries.GetNextNo(WarehouseSetup."Stock Request No.", 0D, TRUE);
        END;
        VALIDATE("Document Date", WORKDATE);
        "Created By" := UserId;
    end;

    trigger OnModify()
    begin
        TestStatusOpen();
    end;

    trigger OnRename()
    begin
        ERROR(Text000, TABLECAPTION);
    end;

    var
        WarehouseSetup: Record "Warehouse Setup";
        StockReqLine: Record "Stock Request Line";
        NoSeries: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
        HideValidationDialog: Boolean;
        Text000: Label 'You cannot rename a %1.';
        Text001: Label 'You do not have permission to run replenishment.';
        Text064: Label 'You may have changed a dimension.\\Do you want to update the lines?';


    local procedure TestStatusOpen()
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify;

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if BuyBackSalesLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if BuyBackSalesLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
        ShippedReceivedItemLineDimChangeConfirmed: Boolean;
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not GetHideValidationDialog and GuiAllowed then
            if not ConfirmUpdateAllLineDim(NewParentDimSetID, OldParentDimSetID) then
                exit;

        StockReqLine.Reset();
        StockReqLine.SetRange("Document No.", "No.");
        StockReqLine.LockTable();
        if StockReqLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(StockReqLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if StockReqLine."Dimension Set ID" <> NewDimSetID then begin
                    StockReqLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      StockReqLine."Dimension Set ID", StockReqLine."Shortcut Dimension 1 Code", StockReqLine."Shortcut Dimension 2 Code");
                    StockReqLine.Modify();
                end;
            until StockReqLine.Next() = 0;
    end;

    procedure GetHideValidationDialog(): Boolean
    begin
        exit(HideValidationDialog or false);
    end;

    local procedure ConfirmUpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer) Confirmed: Boolean;
    begin
        Confirmed := Confirm(Text064);
    end;

    procedure BuyBackSalesLinesExist(): Boolean;
    begin
        StockReqLine.RESET;
        StockReqLine.SETRANGE("Document No.", "No.");
        exit(not StockReqLine.IsEmpty);
    end;

    procedure SetStatusopen()
    begin
        Rec.Status := Rec.Status::Open;
        Rec.Modify();
    end;

    procedure SetStatusReleased()
    begin
        Rec.Status := Rec.Status::Released;
        Rec.Modify();
    end;

}

