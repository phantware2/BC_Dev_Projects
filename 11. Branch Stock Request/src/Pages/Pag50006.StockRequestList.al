page 50006 "Stock Request List"
{
    Caption = 'Branch Stock Request List';
    CardPageID = "Stock Request";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Stock Request Header";
    SourceTableView = SORTING(Status, "Store No.")
    WHERE(Status = filter(Open | "Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Store No."; Rec."Store No.")
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
                field("Reference Type"; Rec."Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Req. Status" := Rec."Req. Status"::New;
        Rec."Document Type" := Rec."Document Type"::"Transfer Order";
    end;

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
        end;// else
            //Rec.SetRange("Created By", UserId);

        if RespCenterCode <> '' then
            Rec.SetFilter("Store No.", RespCenterCode);
    end;

}

