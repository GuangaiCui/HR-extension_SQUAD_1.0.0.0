report 53036 "Hora Extra Colectiva"
{
    //  //-------------------------------------------------------
    //                Hora Extra Colectiva
    //  //--------------------------------------------------------
    //  É um report que serve para registar uma Hora Extra com as
    //  mesmas caracteristicas para vários empregados ao mesmo
    //  tempo.
    //  Está disponível a partir do registo de Horas Extra.
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
                    TabHoraExtra.Init;
                    TabHoraExtra.Validate(TabHoraExtra."Employee No.", Empregado."No.");
                    TabHoraExtra.Validate(TabHoraExtra."Cód. Hora Extra", VarTipoHora);
                    TabHoraExtra.Validate(TabHoraExtra.Data, VarData);
                    TabHoraExtra.Validate(TabHoraExtra.Quantity, VarQuantidade);
                    TabHoraExtra.Insert(true);
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
                group("Hora Extra Colectiva")
                {
                    Caption = 'Hora Extra Colectiva';
                    field(VarTipoHora; VarTipoHora)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Tipo Hora Extra';
                        TableRelation = "Tipos Horas Extra";
                    }
                    field(VarData; VarData)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Data';
                    }
                    field(VarQuantidade; VarQuantidade)
                    {
                        ApplicationArea = HumanResourcesAppArea;
                        Caption = 'Quantidade';
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


        if (VarTipoHora = '') or (VarData = 0D) or (VarQuantidade = 0) then
            Error(Text0001);
    end;

    var
        TabHoraExtra: Record "Horas Extra Empregado";
        VarTipoHora: Code[20];
        VarData: Date;
        VarQuantidade: Decimal;
        Text0001: Label 'Tem de preencher todos os campos das Opções.';
}

