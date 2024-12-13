xmlport 50004 GetClientes
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ClienteList)
        {
            tableelement(Cliente; Customer)
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable();
                    begin
                        No := Cliente."No.";
                    end;
                }
                textelement(Nome)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Nome := Cliente.Name;
                    end;
                }

                textelement(VAT)
                {
                    trigger OnBeforePassVariable();
                    begin
                        VAT := Cliente."VAT Registration No.";
                    end;
                }

                textelement(Filial)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Filial := '';
                    end;
                }

                textelement(Morada)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Morada := Cliente.Address + Cliente."Address 2";
                    end;
                }

                textelement(CodPostal)
                {
                    trigger OnBeforePassVariable();
                    begin
                        CodPostal := Cliente."Post Code";
                    end;
                }

                textelement(Cidade)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Cidade := Cliente.City;
                    end;
                }

                textelement(Pais)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Pais := Cliente."Country/Region Code";
                    end;
                }

                textelement(CondicoesPagamento)
                {
                    trigger OnBeforePassVariable();
                    begin
                        CondicoesPagamento := Cliente."Payment Terms Code";
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    if (DateFilter <> 0D) then
                        Cliente.SetFilter("Last Date Modified", '>=%1', DateFilter);
                end;
            }
        }
    }

    var
        DateFilter: Date;

    procedure SetFilters(dateLastModified: Date)
    begin
        DateFilter := dateLastModified;
    end;
}