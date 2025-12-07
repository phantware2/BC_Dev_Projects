xmlport 50100 "XMLPort Sample"
{
    Format = VariableText;

    schema
    {
        textelement(XMLPORTSAMPLEROOTNODE)
        {
            tableelement(XMLPortSampleParentNode; "XMLPort Sample")
            {
                AutoReplace = false;
                AutoUpdate = true;
                AutoSave = true;

                fieldelement(No; XMLPortSampleParentNode."No.") { }
                fieldelement(Description; XMLPortSampleParentNode.Description) { MinOccurs = Zero; }
                fieldelement(Amount; XMLPortSampleParentNode.Amount) { }
            }
        }
    }
}