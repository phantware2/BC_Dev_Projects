xmlport 50101 "XMLPort Sample XML"
{
    Format = Xml;

    schema
    {
        textelement(XMLFormat)
        {
            tableelement(XMLPortSampleParentNode; "XMLPort Sample")
            {
                AutoUpdate = true;

                fieldelement(SystemID; XMLPortSampleParentNode.SystemId) { }
                textelement(General)
                {
                    fieldelement(No; XMLPortSampleParentNode."No.")
                    {
                        fieldattribute(Description; XMLPortSampleParentNode.Description) { }
                    }
                    fieldelement(Amount; XMLPortSampleParentNode.Amount) { }
                }
                textelement(Logs)
                {
                    fieldelement(DateInserted; XMLPortSampleParentNode."Date Inserted") { }
                    fieldelement(InsertedBy; XMLPortSampleParentNode."Inserted By") { }
                }
            }
        }
    }
}