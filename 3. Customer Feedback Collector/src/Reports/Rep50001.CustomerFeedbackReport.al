report 50001 "Customer Feedback Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = CustomerFeedback;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where(Feedback = filter(<> ''));
            column(No_; "No.")
            { }
            column(Name; Name)
            { }
            column(Feedback; Feedback)
            { }
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field(OnlyWithFeedback; OnlyWithFeedbackOption)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Customers with Feedback';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    rendering
    {
        layout(CustomerFeedback)
        {
            Type = RDLC;
            LayoutFile = './3. Customer Feedback Collector/src/layouts/CustomerFeedback.rdl';
        }
    }

    var
        OnlyWithFeedbackOption: Boolean;
}