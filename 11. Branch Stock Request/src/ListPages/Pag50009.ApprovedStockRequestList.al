page 50009 "Approved Stock Request List"
{
    CardPageID = "Approved Stock Request";
    Editable = false;
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Stock Request Header";
    SourceTableView = SORTING(Status, "Store No.") WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                }
                field("From Store No."; Rec."From Store No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Req. Status"; Rec."Req. Status")
                {
                    ApplicationArea = All;
                }
                field("Reference Type"; Rec."Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Note; Notes)
            {
                Visible = true;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        WarehouseEmployee: Record "Warehouse Employee";
        RespCenterCode: Text;
    begin
        WarehouseEmployee.Reset();
        WarehouseEmployee.SetRange("User ID", UserId);
        if WarehouseEmployee.FindSet() then begin
            repeat
                if RespCenterCode <> '' then
                    RespCenterCode := RespCenterCode + '|' + WarehouseEmployee."Location Code"
                else
                    RespCenterCode := WarehouseEmployee."Location Code";
            until WarehouseEmployee.Next() = 0;
        end;

        if RespCenterCode <> '' then
            Rec.SetFilter("Store No.", RespCenterCode);
    end;
}

