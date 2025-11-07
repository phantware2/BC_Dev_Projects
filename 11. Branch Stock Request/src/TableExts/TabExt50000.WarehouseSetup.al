tableextension 50000 WarehouseSetup extends "Warehouse Setup"
{
    fields
    {
        field(50000; "Stock Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
    }
}