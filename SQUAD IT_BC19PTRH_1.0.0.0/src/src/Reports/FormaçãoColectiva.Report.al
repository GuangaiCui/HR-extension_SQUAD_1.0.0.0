report 53090 "Formação Colectiva"
{
    //  //-------------------------------------------------------
    //                Formação Colectiva
    //  //--------------------------------------------------------
    //  É um report que serve para criar formação para vários
    //  empregados ao mesmo tempo.
    //  Está disponível directamento no registo.
    //  //-------------------------------------------------------

    ProcessingOnly = true;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //Não apanhar os empregados que não estão Activos
                if Empregado.Status = Empregado.Status::Active then begin
                    TabFormaçãoEmpregado.Init;
                    TabFormaçãoEmpregado.Validate("No. Empregado", Empregado."No.");
                    TabFormaçãoEmpregado.Validate(TabFormaçãoEmpregado."Cód. Acção", CodAccao);
                    TabFormaçãoEmpregado.Insert(true);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Formação Colectiva")
                {
                    Caption = 'Formação Colectiva';
                    field(CodAccao; CodAccao)
                    {

                        Caption = 'Cód. Formação';
                        TableRelation = "Acções Formação";
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        "TabFormaçãoEmpregado": Record "Formação Empregado";
        "TabAcçõesEmpregados": Record "Acções Formação";
        CodAccao: Code[30];
        Obs: Text[250];
        "CustoAcção": Decimal;
}

