page 50012 "Customer Feedback Page"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Customer;
    Caption = 'Customer Feedback';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }

                field(Feedback; Rec.Feedback)
                {
                    Caption = 'Feedback';
                    MultiLine = true;
                }
            }
        }
    }
}
