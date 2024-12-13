xmlport 50005 GetFornecedores
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(FornecedorList)
        {
            tableelement(Fornecedor; Vendor)
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable();
                    begin
                        No := Fornecedor."No.";
                    end;
                }
                textelement(Nome)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Nome := Fornecedor.Name;
                    end;
                }

                textelement(VAT)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Nome := Fornecedor."VAT Registration No.";
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
                        Morada := Fornecedor.Address + Fornecedor."Address 2";
                    end;
                }

                textelement(CodPostal)
                {
                    trigger OnBeforePassVariable();
                    begin
                        CodPostal := Fornecedor."Post Code";
                    end;
                }

                textelement(Cidade)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Cidade := Fornecedor.City;
                    end;
                }

                textelement(Pais)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Pais := Fornecedor."Country/Region Code";
                    end;
                }

                textelement(CondicoesPagamento)
                {
                    trigger OnBeforePassVariable();
                    begin
                        CondicoesPagamento := Fornecedor."Payment Terms Code";
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    if (DateFilter <> 0D) then
                        Fornecedor.SetFilter("Last Date Modified", '>=%1', DateFilter);
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