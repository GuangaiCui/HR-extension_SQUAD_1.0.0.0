report 53072 "Mapa Férias Global"
{
    //  //-------------------------------------------------------
    //                 Mapa Férias Global
    //  //--------------------------------------------------------
    //   É um Mapa para listar as férias de todos os empregado
    //   e poder ser afixado na empresa.
    //   Este Report está disponível a partir de Mapas.
    //  //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaFériasGlobal.rdlc';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem(Empregado; Employee)
        {
            DataItemTableView = WHERE(Status = FILTER(<> Terminated));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column("MAPA_DE_FÉRIAS_DE_____FORMAT_VarAno_"; 'MAPA DE FÉRIAS DE ' + Format(VarAno))
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(FORMAT__WORKDATE_0___Day__de__Month_Text__de__Year4___; Format(WorkDate, 0, '<Day> de <Month Text> de <Year4>'))
            {
            }
            column(DezembroCaption; DezembroCaptionLbl)
            {
            }
            column(NovembroCaption; NovembroCaptionLbl)
            {
            }
            column(OutubroCaption; OutubroCaptionLbl)
            {
            }
            column(SetembroCaption; SetembroCaptionLbl)
            {
            }
            column(AgostoCaption; AgostoCaptionLbl)
            {
            }
            column(JulhoCaption; JulhoCaptionLbl)
            {
            }
            column(JunhoCaption; JunhoCaptionLbl)
            {
            }
            column(MaioCaption; MaioCaptionLbl)
            {
            }
            column(AbrilCaption; AbrilCaptionLbl)
            {
            }
            column("MarçoCaption"; MarçoCaptionLbl)
            {
            }
            column(FevereiroCaption; FevereiroCaptionLbl)
            {
            }
            column(JaneiroCaption; JaneiroCaptionLbl)
            {
            }
            column(EmpregadoCaption; EmpregadoCaptionLbl)
            {
            }
            column("A_GerênciaCaption"; A_GerênciaCaptionLbl)
            {
            }
            column(Empregado_No_; "No.")
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            dataitem("Férias Empregados"; "Férias Empregados")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", Data) WHERE(Tipo = CONST(ferias));

                trigger OnAfterGetRecord()
                begin
                    //Saber a fórmula
                    if (Date2DWY(xData, 1) >= 1) and (Date2DWY(xData, 1) <= 4) then
                        Formula := '+1D';
                    if Date2DWY(xData, 1) = 5 then
                        Formula := '+3D';
                    if Date2DWY(xData, 1) = 6 then
                        Formula := '+2D';
                    if Date2DWY(xData, 1) = 7 then
                        Formula := '+1D';

                    //Janeiro
                    if Date2DMY("Férias Empregados".Data, 2) = 1 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Jan, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Jan := CopyStr(Jan, 1, StrPos(Jan, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Jan := Jan + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Jan = '' then
                                Jan := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Jan := Jan + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Fevereiro
                    if Date2DMY("Férias Empregados".Data, 2) = 2 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Fev, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Fev := CopyStr(Fev, 1, StrPos(Fev, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Fev := Fev + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Fev = '' then
                                Fev := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Fev := Fev + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Março
                    if Date2DMY("Férias Empregados".Data, 2) = 3 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Mar, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Mar := CopyStr(Mar, 1, StrPos(Mar, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Mar := Mar + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Mar = '' then
                                Mar := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Mar := Mar + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Abril
                    if Date2DMY("Férias Empregados".Data, 2) = 4 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Abr, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin

                                Abr := CopyStr(Abr, 1, StrPos(Abr, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Abr := Abr + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Abr = '' then
                                Abr := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Abr := Abr + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Maio
                    if Date2DMY("Férias Empregados".Data, 2) = 5 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Mai, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Mai := CopyStr(Mai, 1, StrPos(Mai, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Mai := Mai + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Mai = '' then
                                Mai := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Mai := Mai + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Junho
                    if Date2DMY("Férias Empregados".Data, 2) = 6 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Jun, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Jun := CopyStr(Jun, 1, StrPos(Jun, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Jun := Jun + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Jun = '' then
                                Jun := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Jun := Jun + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Julho
                    if Date2DMY("Férias Empregados".Data, 2) = 7 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Jul, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Jul := CopyStr(Jul, 1, StrPos(Jul, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Jul := Jul + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Jul = '' then
                                Jul := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Jul := Jul + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Agosto
                    if Date2DMY("Férias Empregados".Data, 2) = 8 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Ago, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Ago := CopyStr(Ago, 1, StrPos(Ago, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Ago := Ago + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Ago = '' then
                                Ago := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Ago := Ago + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;

                    //Setembro
                    if Date2DMY("Férias Empregados".Data, 2) = 9 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Set, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin

                                Set := CopyStr(Set, 1, StrPos(Set, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));

                            end else
                                Set := Set + '..' + Format(Date2DMY("Férias Empregados".Data, 1));

                        end else begin
                            if Set = '' then
                                Set := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Set := Set + ',' + Format(Date2DMY("Férias Empregados".Data, 1));

                        end;
                        xData := "Férias Empregados".Data;

                    end;

                    //Outubro
                    if Date2DMY("Férias Empregados".Data, 2) = 10 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Out, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin

                                Out := CopyStr(Out, 1, StrPos(Out, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));

                            end else
                                Out := Out + '..' + Format(Date2DMY("Férias Empregados".Data, 1));

                        end else begin
                            if Out = '' then
                                Out := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Out := Out + ',' + Format(Date2DMY("Férias Empregados".Data, 1));

                        end;
                        xData := "Férias Empregados".Data;

                    end;

                    //Novembro
                    if Date2DMY("Férias Empregados".Data, 2) = 11 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Nov, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin

                                Nov := CopyStr(Nov, 1, StrPos(Nov, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));

                            end else
                                Nov := Nov + '..' + Format(Date2DMY("Férias Empregados".Data, 1));

                        end else begin
                            if Nov = '' then
                                Nov := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Nov := Nov + ',' + Format(Date2DMY("Férias Empregados".Data, 1));

                        end;
                        xData := "Férias Empregados".Data;

                    end;

                    //Dezembro
                    if Date2DMY("Férias Empregados".Data, 2) = 12 then begin
                        if "Férias Empregados".Data = CalcDate(Formula, xData) then begin
                            if StrPos(Dez, '..' + Format(Date2DMY(xData, 1))) <> 0 then begin
                                Dez := CopyStr(Dez, 1, StrPos(Dez, '..' + Format(Date2DMY(xData, 1))) - 1) +
                                '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                            end else
                                Dez := Dez + '..' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end else begin
                            if Dez = '' then
                                Dez := Format(Date2DMY("Férias Empregados".Data, 1))
                            else
                                Dez := Dez + ',' + Format(Date2DMY("Férias Empregados".Data, 1));
                        end;
                        xData := "Férias Empregados".Data;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "Férias Empregados".SetRange("Férias Empregados".Data, DMY2Date(1, 1, VarAno), DMY2Date(31, 12, VarAno));
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(Jan; Jan)
                {
                }
                column(Fev; Fev)
                {
                }
                column(Mar; Mar)
                {
                }
                column(Abr; Abr)
                {
                }
                column(Jul; Jul)
                {
                }
                column(Jun; Jun)
                {
                }
                column(Mai; Mai)
                {
                }
                column(Dez; Dez)
                {
                }
                column(Nov; Nov)
                {
                }
                column(Out; Out)
                {
                }
                column(Set; Set)
                {
                }
                column(Ago; Ago)
                {
                }
                column(Empregado_Name; Empregado.Name)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin

                    Integer.SetRange(Integer.Number, 1, 1);
                    i := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                xData := DMY2Date(1, 1, 1000);
                Clear(Jan);
                Clear(Fev);
                Clear(Mar);
                Clear(Abr);
                Clear(Mai);
                Clear(Jun);
                Clear(Jul);
                Clear(Ago);
                Clear(Set);
                Clear(Out);
                Clear(Nov);
                Clear(Dez);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Mapa Férias Global")
                {
                    Caption = 'Mapa Férias Global';
                    field(VarAno; VarAno)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
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

    trigger OnInitReport()
    begin
        VarAno := Date2DMY(WorkDate, 3);

        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        Jan: Text[30];
        Fev: Text[30];
        Mar: Text[30];
        Abr: Text[30];
        Mai: Text[30];
        Jun: Text[30];
        Jul: Text[30];
        Ago: Text[30];
        Set: Text[30];
        Out: Text[30];
        Nov: Text[30];
        Dez: Text[30];
        i: Integer;
        VarAno: Integer;
        TabConfEmpresa: Record "Company Information";
        xData: Date;
        Formula: Text[30];
        DezembroCaptionLbl: Label 'Dezembro';
        NovembroCaptionLbl: Label 'Novembro';
        OutubroCaptionLbl: Label 'Outubro';
        SetembroCaptionLbl: Label 'Setembro';
        AgostoCaptionLbl: Label 'Agosto';
        JulhoCaptionLbl: Label 'Julho';
        JunhoCaptionLbl: Label 'Junho';
        MaioCaptionLbl: Label 'Maio';
        AbrilCaptionLbl: Label 'Abril';
        "MarçoCaptionLbl": Label 'Março';
        FevereiroCaptionLbl: Label 'Fevereiro';
        JaneiroCaptionLbl: Label 'Janeiro';
        EmpregadoCaptionLbl: Label 'Empregado';
        "A_GerênciaCaptionLbl": Label 'A Gerência';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
}

