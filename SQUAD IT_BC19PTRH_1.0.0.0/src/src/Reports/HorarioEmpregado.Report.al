report 53086 "Horario Empregado"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/HorarioEmpregado.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Horário Empregado"; "Horário Empregado")
        {
            DataItemTableView = SORTING("No. Empregado", "Data Iníco Horário", "Dia da Semana");
            RequestFilterFields = "No. Empregado", "Data Iníco Horário", "Data Fim Horário";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
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
            column("Horário_Empregado_"; 'Horário Empregado')
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
            column(DataFim; DataFim)
            {
            }
            column(DataInicio; DataInicio)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(a__Caption; a__CaptionLbl)
            {
            }
            column("Período_de___Caption"; Período_de___CaptionLbl)
            {
            }
            column("Horário_Empregado___No__Empregado_Caption"; FieldCaption("No. Empregado"))
            {
            }
            column(NomeCaption; NomeCaptionLbl)
            {
            }
            column("Horário_Empregado___Cód__Horário_Caption"; FieldCaption("Cód. Horário"))
            {
            }
            column("Horário_RH__Hora_Entrada_Caption"; "Horário RH".FieldCaption("Hora Entrada"))
            {
            }
            column("Horário_RH__Hora_Saída_Caption"; "Horário RH".FieldCaption("Hora Saída"))
            {
            }
            column("Horário_RH__Hora_Início_Almoço_Caption"; "Horário RH".FieldCaption("Hora Início Almoço"))
            {
            }
            column("Horário_RH__Hora_Fim_Almoço_Caption"; "Horário RH".FieldCaption("Hora Fim Almoço"))
            {
            }
            column("Horário_RH__No__Horas_Diárias_Caption"; "Horário RH".FieldCaption("No. Horas Diárias"))
            {
            }
            column("MêsCaption"; MêsCaptionLbl)
            {
            }
            column(Dia_da_SemanaCaption; Dia_da_SemanaCaptionLbl)
            {
            }
            column("Horário_Empregado_No__Empregado"; "No. Empregado")
            {
            }
            column("Horário_Empregado_Cód__Horário"; "Cód. Horário")
            {
            }
            column("Horário_Empregado_No__Linha"; "No. Linha")
            {
            }
            column("Horário_Empregado_Data_Inicio_Horario"; "Data Iníco Horário")
            {
            }
            column("Horário_Empregado_Dia_da_Semana"; "Dia da Semana")
            {
            }
            dataitem("Horário RH"; "Horário RH")
            {
                DataItemLink = "Código" = FIELD("Cód. Horário");
                DataItemTableView = SORTING("Código") ORDER(Ascending);
                column("Horário_Empregado___No__Empregado_"; "Horário Empregado"."No. Empregado")
                {
                }
                column(NomeEmpregado; NomeEmpregado)
                {
                }
                column("Horário_Empregado___Cód__Horário_"; "Horário Empregado"."Cód. Horário")
                {
                }
                column("Horário_RH__Hora_Entrada_"; "Hora Entrada")
                {
                }
                column("Horário_RH__Hora_Saída_"; "Hora Saída")
                {
                }
                column("Horário_RH__Hora_Início_Almoço_"; "Hora Início Almoço")
                {
                }
                column("Horário_RH__Hora_Fim_Almoço_"; "Hora Fim Almoço")
                {
                }
                column("Horário_RH__No__Horas_Diárias_"; "No. Horas Diárias")
                {
                }
                column("Horário_Empregado___Dia_da_Semana_"; "Horário Empregado"."Dia da Semana")
                {
                }
                column("Horário_Empregado__Mês"; "Horário Empregado".Mês)
                {
                }
                column("Horário_RH_Código"; Código)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if rEmpregado.Get("Horário Empregado"."No. Empregado") then
                        NomeEmpregado := rEmpregado.Name
                    else
                        NomeEmpregado := '';
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No. Empregado");

                DataInicio := "Horário Empregado".GetFilter("Horário Empregado"."Data Iníco Horário");
                DataFim := "Horário Empregado".GetFilter("Horário Empregado"."Data Fim Horário");
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        VarAno := Date2DMY(WorkDate, 3);
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(TabConfEmpresa.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TabConfEmpresa: Record "Company Information";
        VarAno: Integer;
        rEmpregado: Record Employee;
        NomeEmpregado: Text[250];
        DataInicio: Text[30];
        DataFim: Text[30];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        a__CaptionLbl: Label 'a: ';
        "Período_de___CaptionLbl": Label 'Período de:  ';
        NomeCaptionLbl: Label 'Nome';
        "MêsCaptionLbl": Label 'Mês';
        Dia_da_SemanaCaptionLbl: Label 'Dia da Semana';
}

