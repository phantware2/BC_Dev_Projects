page 50100 "XMLPort Sample"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "XMLPort Sample";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Date Inserted"; Rec."Date Inserted")
                {
                    ApplicationArea = All;
                }
                field("Inserted By"; Rec."Inserted By")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Import/Export")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                RunObject = xmlport "XMLPort Sample";

                trigger OnAction()
                begin

                end;
            }
            action("XML Export")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                RunObject = xmlport "XMLPort Sample XML";

                trigger OnAction()
                begin

                end;
            }
        }
    }
}

