xmlport 50002 GetCentrosCusto
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(CentroCustoList)
        {
            tableelement(CentroCusto; "Dimension Value")
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable();
                    begin
                        No := CentroCusto.Code;
                    end;
                }
                textelement(Nome)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Nome := CentroCusto.Name;
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    CentroCusto.SetRange("Dimension Code", 'CC');
                end;
            }
        }
    }
}