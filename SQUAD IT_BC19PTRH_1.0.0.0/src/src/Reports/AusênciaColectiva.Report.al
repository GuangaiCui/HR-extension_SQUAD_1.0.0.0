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
        dataitem(Empregado; Empregado)
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
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Cód. Mot. Ausência';
                        TableRelation = "Absence Reason";
                    }
                    field(VarAPartirData; VarAPartirData)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'A Partir da Data';
                    }
                    field(VarAData; VarAData)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'À Data';
                    }
                    field(VarQuantidade; VarQuantidade)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Quantidade';
                    }
                    field(VarUnidadeMedida; VarUnidadeMedida)
                    {
                        ApplicationArea = HumanResourcesAppArea;
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

