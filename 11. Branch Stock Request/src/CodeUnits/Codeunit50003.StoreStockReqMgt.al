codeunit 50003 "Store Stock Req Mgt"
{
    procedure CreateTransferOrder(var StockReHeader: Record "Stock Request Header")
    begin
        Message('My name is %1, I have reached CreateTransferOrder codeunit', StockReHeader."No.");
    end;
}