table 50004 "Stock Request"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Store No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; Status; Enum Status)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Reference Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Document,Item,Customer,Vendor,PurchaseOrder,TransferOrder,Other;
            OptionCaption = 'Document,Item,Customer,Vendor,Purchase Order,Transfer Order,Other';
            Editable = false;
        }
        field(6; "Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = SalesInvoice,CreditMemo,ServiceOrder,PurchaseInvoice,TransferOrder;
            OptionCaption = 'Sales Invoice,Credit Memo,Service Order,Purchase Invoice,Transfer Order';
        }
        field(8; "Process Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = New,Create,Update,Approve,Reject,Complete,Cancel,Other;
            OptionCaption = 'New,Create,Update,Approve,Reject,Complete,Cancel,Other';
        }
        field(9; "From Store No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "In-Transit Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Created By"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(14; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                CustRec: Record Customer;
            begin
                if CustRec.Get(Rec."Customer No.") then
                    "Customer Name" := CustRec.Name;
            end;
        }
        field(15; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Ticket No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}