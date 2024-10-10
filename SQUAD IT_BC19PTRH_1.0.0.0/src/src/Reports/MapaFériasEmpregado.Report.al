report 53057 "Mapa Férias Empregado"
{
    //  //-------------------------------------------------------
    //                 Mapa Férias de Empregado
    //  //--------------------------------------------------------
    //   É um Mapa para listar as férias de cada empregado e poder
    //   ser assinado pelo próprio e respectiva Chefia.
    //   Este Report está disponível a partir de Mapas.
    //  //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\MapaFériasEmpregado.rdl';

    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
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
            column(Empregado_Empregado__No__; Empregado."No.")
            {
            }
            column(Empregado_Empregado_Name; Empregado.Name)
            {
            }
            column(VarCodEstatistico; VarCodEstatistico)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Empregado_Caption; Empregado_CaptionLbl)
            {
            }
            column(DiaCaption; DiaCaptionLbl)
            {
            }
            column(JaneiroCaption; JaneiroCaptionLbl)
            {
            }
            column(FevereiroCaption; FevereiroCaptionLbl)
            {
            }
            column("MarçoCaption"; MarçoCaptionLbl)
            {
            }
            column(AbrilCaption; AbrilCaptionLbl)
            {
            }
            column(MaioCaption; MaioCaptionLbl)
            {
            }
            column(JunhoCaption; JunhoCaptionLbl)
            {
            }
            column(JulhoCaption; JulhoCaptionLbl)
            {
            }
            column(AgostoCaption; AgostoCaptionLbl)
            {
            }
            column(SetembroCaption; SetembroCaptionLbl)
            {
            }
            column(OutubroCaption; OutubroCaptionLbl)
            {
            }
            column(NovembroCaption; NovembroCaptionLbl)
            {
            }
            column(DezembroCaption; DezembroCaptionLbl)
            {
            }
            column(Departamento_Caption; Departamento_CaptionLbl)
            {
            }
            column(Processado_por_ComputadorCaption; Processado_por_ComputadorCaptionLbl)
            {
            }
            dataitem("Férias Empregados"; "Férias Empregados")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", Data) WHERE(Tipo = CONST(ferias));

                trigger OnAfterGetRecord()
                begin
                    //Janeiro
                    if Date2DMY("Férias Empregados".Data, 2) = 1 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Jan[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Jan[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Fevereiro
                    if Date2DMY("Férias Empregados".Data, 2) = 2 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Fev[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Fev[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Março
                    if Date2DMY("Férias Empregados".Data, 2) = 3 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Mar[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Mar[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Abril
                    if Date2DMY("Férias Empregados".Data, 2) = 4 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Abr[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Abr[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Maio
                    if Date2DMY("Férias Empregados".Data, 2) = 5 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Mai[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Mai[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Junho
                    if Date2DMY("Férias Empregados".Data, 2) = 6 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Jun[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Jun[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Julho
                    if Date2DMY("Férias Empregados".Data, 2) = 7 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Jul[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Jul[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Agosto
                    if Date2DMY("Férias Empregados".Data, 2) = 8 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Ago[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Ago[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Setembro
                    if Date2DMY("Férias Empregados".Data, 2) = 9 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Set[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Set[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Outubro
                    if Date2DMY("Férias Empregados".Data, 2) = 10 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Out[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Out[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Novembro
                    if Date2DMY("Férias Empregados".Data, 2) = 11 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Nov[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Nov[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
                    end;

                    //Dezembro
                    if Date2DMY("Férias Empregados".Data, 2) = 12 then begin
                        if "Férias Empregados"."Ano a que se refere" = VarAno then
                            Dez[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.")
                        else
                            Dez[Date2DMY("Férias Empregados".Data, 1)] := Format("Férias Empregados"."Qtd.") + ' (' + Format("Férias Empregados"."Ano a que se refere") + ')';
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
                column(Jan_i_; Jan[i])
                {
                }
                column(i; i)
                {
                }
                column(Fev_i_; Fev[i])
                {
                }
                column(Mar_i_; Mar[i])
                {
                }
                column(Abr_i_; Abr[i])
                {
                }
                column(Jul_i_; Jul[i])
                {
                }
                column(Jun_i_; Jun[i])
                {
                }
                column(Mai_i_; Mai[i])
                {
                }
                column(Dez_i_; Dez[i])
                {
                }
                column(Nov_i_; Nov[i])
                {
                }
                column(Out_i_; Out[i])
                {
                }
                column(Set_i_; Set[i])
                {
                }
                column(Ago_i_; Ago[i])
                {
                }
                column(WORKDATE; WorkDate)
                {
                }
                column(O_EmpregadoCaption; O_EmpregadoCaptionLbl)
                {
                }
                column(A_ChefiaCaption; A_ChefiaCaptionLbl)
                {
                }
                column(Recursos_HumanosCaption; Recursos_HumanosCaptionLbl)
                {
                }
                column(Data_Caption; Data_CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    i := i + 1;
                end;

                trigger OnPreDataItem()
                begin
                    i := 0;
                    Integer.SetRange(Integer.Number, 1, 31);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if TabGrEstEmpregado.Get(Empregado."Statistics Group Code") then
                    VarCodEstatistico := TabGrEstEmpregado.Description;

                //2008.05.09
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
                group("Mapa Férias Empregado")
                {
                    Caption = 'Mapa Férias Empregado';
                    field(VarAno; VarAno)
                    {

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
        Jan: array[31] of Text[30];
        Fev: array[31] of Text[30];
        Mar: array[31] of Text[30];
        Abr: array[31] of Text[30];
        Mai: array[31] of Text[30];
        Jun: array[31] of Text[30];
        Jul: array[31] of Text[30];
        Ago: array[31] of Text[30];
        Set: array[31] of Text[30];
        Out: array[31] of Text[30];
        Nov: array[31] of Text[30];
        Dez: array[31] of Text[30];
        i: Integer;
        VarAno: Integer;
        VarCodEstatistico: Text[100];
        TabGrEstEmpregado: Record "Departamentos Empregado";
        TabConfEmpresa: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Empregado_CaptionLbl: Label 'Empregado:';
        DiaCaptionLbl: Label 'Dia';
        JaneiroCaptionLbl: Label 'Janeiro';
        FevereiroCaptionLbl: Label 'Fevereiro';
        "MarçoCaptionLbl": Label 'Março';
        AbrilCaptionLbl: Label 'Abril';
        MaioCaptionLbl: Label 'Maio';
        JunhoCaptionLbl: Label 'Junho';
        JulhoCaptionLbl: Label 'Julho';
        AgostoCaptionLbl: Label 'Agosto';
        SetembroCaptionLbl: Label 'Setembro';
        OutubroCaptionLbl: Label 'Outubro';
        NovembroCaptionLbl: Label 'Novembro';
        DezembroCaptionLbl: Label 'Dezembro';
        Departamento_CaptionLbl: Label 'Departamento:';
        O_EmpregadoCaptionLbl: Label 'O Empregado';
        A_ChefiaCaptionLbl: Label 'A Chefia';
        Recursos_HumanosCaptionLbl: Label 'Recursos Humanos';
        Data_CaptionLbl: Label 'Data:';
        "X___Férias_Ano_CorrenteCaptionLbl": Label 'X - Férias Ano Corrente';
        "A___Férias_Ano_AnteriorCaptionLbl": Label 'A - Férias Ano Anterior';
        Processado_por_ComputadorCaptionLbl: Label 'Processado por Computador';
}

