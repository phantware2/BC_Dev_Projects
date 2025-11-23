codeunit 50003 "Store Stock Req Mgt"
{
    procedure CreateTransferOrder(var StockReHeader: Record "Stock Request Header")
    var
        xStockReHeader: Record "Stock Request Header";
        StockReqLine: Record "Stock Request Line";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
    begin
        xStockReHeader.Get(StockReHeader."No.");
        xStockReHeader.TestField(Status, xStockReHeader.Status::Released);

        StockReqLine.Reset();
        StockReqLine.SetRange("Document No.", xStockReHeader."No.");
        StockReqLine.SetFilter("Allocated Quantity", '<> %1', 0);
        StockReqLine.SetRange("Transfer Order Created", false);

        if StockReqLine.Find('-') then begin
            TransferHeader.Init();
            TransferHeader."No." := '';
            TransferHeader.Insert(true);
            TransferHeader.Validate("Transfer-from Code", StockReHeader."From Store No.");
            TransferHeader.TestField("Transfer-from Code");
            TransferHeader.Validate("Transfer-to Code", StockReHeader."Store No.");
            TransferHeader.TestField("Transfer-to Code");
            TransferHeader.Validate("In-Transit Code", StockReHeader."In-Transit Code");
            TransferHeader.TestField("In-Transit Code");
            if xStockReHeader."Shortcut Dimension 1 Code" <> '' then
                TransferHeader.Validate("Shortcut Dimension 1 Code", xStockReHeader."Shortcut Dimension 1 Code");
            if xStockReHeader."Shortcut Dimension 2 Code" <> '' then
                TransferHeader.Validate("Shortcut Dimension 2 Code", xStockReHeader."Shortcut Dimension 2 Code");
            TransferHeader.Modify(true);

            repeat
                TransferLine.Init();
                TransferLine.Validate("Document No.", TransferHeader."No.");
                TransferLine.Validate("SG_B2B No.", StockReqLine."Item No.");
                TransferLine.Validate("Item No.", StockReqLine."Item No.");
                TransferLine.Validate(Quantity, StockReqLine."Allocated Quantity");
                TransferLine.Validate("Unit of Measure Code", StockReqLine."Unit of Measure Code");
                TransferLine.Validate(Quantity, StockReqLine."Allocated Quantity");
                if StockReqLine."Shortcut Dimension 1 Code" <> '' then
                    TransferLine.Validate("Shortcut Dimension 1 Code", StockReqLine."Shortcut Dimension 1 Code");
                if StockReqLine."Shortcut Dimension 2 Code" <> '' then
                    TransferLine.Validate("Shortcut Dimension 2 Code", StockReqLine."Shortcut Dimension 2 Code");
                TransferLine.Insert();
                StockReqLine."Transfer Order Created" := true;
                StockReqLine.Modify();
            until StockReqLine.Next() = 0;
        end;
        if xStockReHeader."Req. Status" <> xStockReHeader."Req. Status"::Accepted then begin
            xStockReHeader."Req. Status" := xStockReHeader."Req. Status"::Accepted;
            xStockReHeader."Reference Type" := xStockReHeader."Reference Type"::Transfer;
            xStockReHeader."Reference No." := TransferHeader."No.";
            xStockReHeader.Modify();
        end;
    end;
}