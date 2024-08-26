report 53035 "Ausência Colectiva"
{
    //  //-------------------------------------------------------
    //                Ausencia Colectiva
    //  //--------------------------------------------------------
    //  É um report que serve para criar uma ausencia com as
    //  mesmas caracteristicas para vários empregados ao mesmo
    //  tempo.
    //  Está disponível a partir do registo de Ausencias.
    //  //-------------------------------------------------------

    ProcessingOnly = true;

    dataset
    {
        dataitem(Empregado; Employee)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //Não apanhar os empregados que não estão Activos
                if Empregado.Status = Empregado.Status::Active then begin
                    Clear(TabAusencia);

                    if TabAusencia.FindLast then
                        nMov := TabAusencia."Entry No." + 1
                    else
                        nMov := 1;

                    TabAusencia.Init;
                    TabAusencia."Entry No." := nMov;
                    TabAusencia.Validate(TabAusencia."Employee No.", Empregado."No.");
                    TabAusencia.Validate(TabAusencia."Cause of Absence Code", VarCodMotivo);
                    TabAusencia.Validate(TabAusencia."From Date", VarAPartirData);
                    TabAusencia.Validate(TabAusencia."To Date", VarAData);
                    TabAusencia.Validate(TabAusencia.Quantity, VarQuantidade);
                    TabAusencia.Validate(TabAusencia."Unit of Measure Code", VarUnidadeMedida);
                    TabAusencia.Insert;
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
                group("Ausência Colectiva")
                {
                    Caption = 'Ausência Colectiva';
                    field(VarCodMotivo; VarCodMotivo)
                    {

                        Caption = 'Cód. Mot. Ausência';
                        TableRelation = "Absence Reason";
                    }
                    field(VarAPartirData; VarAPartirData)
                    {

                        Caption = 'A Partir da Data';
                    }
                    field(VarAData; VarAData)
                    {

                        Caption = 'À Data';
                    }
                    field(VarQuantidade; VarQuantidade)
                    {

                        Caption = 'Quantidade';
                    }
                    field(VarUnidadeMedida; VarUnidadeMedida)
                    {

                        Caption = 'Unidade Medida';
                        TableRelation = "Unid. Medida Recursos Humanos";
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

    trigger OnPreReport()
    begin
        if (VarCodMotivo = '') or (VarAPartirData = 0D) or (VarAData = 0D) or (VarQuantidade = 0) or (VarUnidadeMedida = '') then
            Error(Text0001);
    end;

    var
        TabAusencia: Record "Ausência Empregado";
        VarCodMotivo: Code[20];
        VarAPartirData: Date;
        VarAData: Date;
        VarQuantidade: Decimal;
        VarUnidadeMedida: Code[10];
        Text0001: Label 'Tem de preencher todos os campos das Opções.';
        nMov: Integer;
}

