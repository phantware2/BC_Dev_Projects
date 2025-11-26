tableextension 50002 CustomerFeedbackExt extends Customer
{
    fields
    {
        field(50100; "Feedback"; Text[250])
        {
            Caption = 'Feedback';
            DataClassification = CustomerContent;
        }
    }
}
