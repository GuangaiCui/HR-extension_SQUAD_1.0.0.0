xmlport 50000 GetEmpregados
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(EmpregadoList)
        {
            tableelement(Empregado; Empregado)
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable();
                    begin
                        No := Empregado."No.";
                    end;
                }

                textelement(Nome)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Nome := Empregado.Name;
                    end;
                }

                textelement(Estado)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Estado := Format(Empregado.Status);
                    end;
                }

                textelement(Email)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Email := Empregado."Company E-Mail";
                    end;
                }

                textelement(Funcao)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Funcao := Empregado."Job Title";
                    end;
                }
                textelement(Departmento)
                {
                    trigger OnBeforePassVariable();
                    var
                        dimensionValue: Record "Default Dimension";
                    begin
                        dimensionValue.Reset();
                        dimensionValue.SetFilter("No.", Empregado."No.");
                        dimensionValue.SetFilter("Dimension Code", 'DEPARTMENT');

                        if dimensionValue.FindFirst() then begin
                            Departmento := dimensionValue."Dimension Value Code";
                        end else begin
                            Departmento := '';
                        end;
                    end;
                }
                textelement(Empresa)
                {
                    trigger OnBeforePassVariable()
                    begin
                    end;
                }
                //Não temos um valor genérico que o user tem. Temos registo de horas extra mas o valor unitário pode variar.
                textelement(ValorHoraReal)
                {
                    trigger OnBeforePassVariable()
                    begin
                    end;
                }
                //Não temos um valor genérico que o user tem. Temos registo de horas extra mas o valor unitário pode variar.
                textelement(ValorCustoDiaria)
                {
                    trigger OnBeforePassVariable()
                    begin
                    end;
                }
                //Não temos um valor genérico que o user tem. Temos registo de horas extra mas o valor unitário pode variar.
                textelement(ValorDiaExtra)
                {
                    trigger OnBeforePassVariable()
                    begin
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    if DateFilter <> 0D then
                        Empregado.SetFilter("Last Date Modified", '>=%1', DateFilter);
                end;

                //Departamento a que pertence
                //Número identificativo no BC caso seja informação proveniente de outro sistema ( se mantivermos o Innux por exemplo)
            }
        }
    }

    // trigger OnPreXmlPort()
    // var
    //     myInt: Integer;
    //     day: Integer;
    //     month: Integer;
    //     year: Integer;
    // begin
    //     Empregado.SetFilter("Last Date Modified", '>=%1', DateFilter);
    // end;

    var
        DateFilter: Date;

    procedure SetFilters(dateLastModified: Date)
    begin
        DateFilter := dateLastModified;
    end;
}