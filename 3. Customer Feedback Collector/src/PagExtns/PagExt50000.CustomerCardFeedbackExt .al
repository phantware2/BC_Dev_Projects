pageextension 50002 CustomerCardFeedbackExt extends "Customer Card"
{
    actions
    {

        addafter(Contact_Promoted)
        {
            actionref(CaptureFeedback_Promoted; CaptureFeedback)
            {
            }
        }

        addlast(Processing)
        {
            action(CaptureFeedback)
            {
                Caption = 'Capture Feedback';
                Image = EditLines;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomerRec: Record Customer;
                begin
                    CustomerRec := Rec;
                    // PAGE.RunModal(PAGE::"Customer Feedback Page", CustomerRec);
                end;
            }
        }
    }
}
