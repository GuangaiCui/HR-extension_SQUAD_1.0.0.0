report 53092 "Marcação Férias por Periodo"
{
    //  //-------------------------------------------------------
    //                Marcação Férias por Periodo
    //  //--------------------------------------------------------
    //  É um report que serve para registar Férias por
    //  peridos de tempo em vez de ser linha a linha
    //  Está disponível a partir da Marcação de Férias.
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
                    TabData.Reset;
                    TabData.SetRange(TabData."Period Type", TabData."Period Type"::Date);
                    TabData.SetRange(TabData."Period Start", VarAPartirData, VarAData);
                    if TabData.FindSet then begin
                        repeat
                            if Date2DWY(TabData."Period Start", 1) < 6 then begin // OS VALORES 6 E 7 CORRESPONDEM A SÁBADO E DOMINGO
                                                                                  //PROCURA SE É FERIADO
                                Feriados.SetRange(Feriados.Data, TabData."Period Start");
                                if not Feriados.FindFirst then begin
                                    TabFeriasEmpregado.Reset;
                                    if not TabFeriasEmpregado.Get(Empregado."No.", TabData."Period Start") then begin
                                        TabFeriasEmpregado.Init;
                                        TabFeriasEmpregado."No. Empregado" := Empregado."No.";
                                        TabFeriasEmpregado.Data := TabData."Period Start";
                                        if Tipo = Tipo::Ferias then
                                            TabFeriasEmpregado.Tipo := 0
                                        else
                                            TabFeriasEmpregado.Tipo := 1;
                                        TabFeriasEmpregado."Ano a que se refere" := Date2DMY(WorkDate, 3);
                                        TabFeriasEmpregado."Qtd." := 1;
                                        if Tipo = Tipo::Ferias then
                                            TabFeriasEmpregado.Insert;
                                        Flag := true;
                                    end;
                                end;
                            end;
                        until TabData.Next = 0;
                    end;
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
                group("Marcação Férias por Periodo ")
                {
                    Caption = 'Marcação Férias por Periodo ';
                    field(VarAPartirData; VarAPartirData)
                    {

                        Caption = 'A Partir da Data';
                    }
                    field(VarAData; VarAData)
                    {

                        Caption = 'À Data';
                    }
                    field(Tipo; Tipo)
                    {

                        Caption = 'Type';
                        OptionCaption = 'Férias,Compensação';
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

    trigger OnPostReport()
    begin
        if Flag = true then Message(Text0002);
    end;

    trigger OnPreReport()
    begin
        Flag := false;

        if (VarAPartirData = 0D) or (VarAData = 0D) then
            Error(Text0001);
    end;

    var
        VarAPartirData: Date;
        VarAData: Date;
        Text0001: Label 'Tem de preencher todos os campos das Opções.';
        TabFeriasEmpregado: Record "Férias Empregados";
        TabData: Record Date;
        Feriados: Record "Feriados RH";
        Text0002: Label 'Processo concluído.';
        Flag: Boolean;
        Tipo: Option Ferias,Compensacao;
}

