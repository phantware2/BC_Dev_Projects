codeunit 50001 "File Upload"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterGetRefTable, '', false, false)]
    local procedure OnAfterGetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")

    var
        ExpenseRecord: Record "Expense Header";
    begin
        case DocumentAttachment."Table ID" of

            Database::"Expense Header":
                begin
                    RecRef.Open(Database::"Expense Header");
                    if ExpenseRecord.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ExpenseRecord);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterTableHasNumberFieldPrimaryKey, '', false, false)]
    local procedure OnAfterTableHasNumberFieldPrimaryKey(TableNo: Integer; var FieldNo: Integer; var Result: Boolean)
    var
        ExpenseRecord: Record "Expense Header";

    begin
        begin
            case TableNo of
                Database::"Expense Header":
                    begin
                        Result := true;
                        FieldNo := ExpenseRecord.FieldNo("No.");
                    end
            end;
        end;
    end;
}