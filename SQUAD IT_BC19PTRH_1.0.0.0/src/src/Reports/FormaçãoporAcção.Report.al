report 53091 "Formação por Acção"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/FormaçãoporAcção.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Acções Formação"; "Acções Formação")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Código", "Data Início", "Data Fim", "Nome Entidade Prestadora";
            column(TabConfEmpresa_Picture; TabConfEmpresa.Picture)
            {
            }
            column(N__Contribuinte______TabConfEmpresa__VAT_Registration_No__; 'Nº Contribuinte: ' + TabConfEmpresa."VAT Registration No.")
            {
            }
            column(N__Telefone______TabConfEmpresa__Phone_No__; 'Nº Telefone: ' + TabConfEmpresa."Phone No.")
            {
            }
            column(TabConfEmpresa__Post_Code_; TabConfEmpresa."Post Code")
            {
            }
            column(TabConfEmpresa_City; TabConfEmpresa.City)
            {
            }
            column(TabConfEmpresa_Address; TabConfEmpresa.Address)
            {
            }
            column(TabConfEmpresa__Name_2_; TabConfEmpresa."Name 2")
            {
            }
            column(USERID; UserId)
            {
            }
            column(TabConfEmpresa_Name; TabConfEmpresa.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column("Acções_Formação__Código____________Acções_Formação__Descrição"; "Acções Formação".Código + ' - ' + "Acções Formação".Descrição)
            {
            }
            column("Acções_Formação__No__Horas_Acção_"; "No. Horas Acção")
            {
            }
            column("Acções_Formação__Data_Fim_"; "Data Fim")
            {
            }
            column("Acções_Formação__Data_Início_"; "Data Início")
            {
            }
            column("Acções_Formação_Tipo"; Tipo)
            {
            }
            column("Acções_Formação__Local_"; "Local")
            {
            }
            column("Acções_Formação__Nome_Entidade_Prestadora_"; "Nome Entidade Prestadora")
            {
            }
            column("Acções_Formação__Nome_Formador_"; "Nome Formador")
            {
            }
            column("FORMAÇÃO_POR_ACÇÃOCaption"; FORMAÇÃO_POR_ACÇÃOCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("AcçãoCaption"; AcçãoCaptionLbl)
            {
            }
            column(N__HorasCaption; N__HorasCaptionLbl)
            {
            }
            column("Acções_Formação__Data_Fim_Caption"; FieldCaption("Data Fim"))
            {
            }
            column("Acções_Formação__Data_Início_Caption"; FieldCaption("Data Início"))
            {
            }
            column("Acções_Formação_TipoCaption"; FieldCaption(Tipo))
            {
            }
            column("Acções_Formação__Local_Caption"; FieldCaption("Local"))
            {
            }
            column("Acções_Formação__Nome_Entidade_Prestadora_Caption"; FieldCaption("Nome Entidade Prestadora"))
            {
            }
            column("Acções_Formação__Nome_Formador_Caption"; FieldCaption("Nome Formador"))
            {
            }
            column("Acções_Formação_Código"; Código)
            {
            }
            dataitem("Formação Empregado"; "Formação Empregado")
            {
                DataItemLink = "Cód. Acção" = FIELD("Código");
                DataItemTableView = SORTING("Cód. Acção", "No. Empregado", "Data Início");
                column("Formação_Empregado_Observações"; Observações)
                {
                }
                column("Formação_Empregado_Avaliação"; Avaliação)
                {
                }
                column("Formação_Empregado__No__Empregado_"; "No. Empregado")
                {
                }
                column(Nome; Nome)
                {
                }
                column(TotalFormandos; TotalFormandos)
                {
                }
                column(EmpregadoCaption; EmpregadoCaptionLbl)
                {
                }
                column("Formação_Empregado_AvaliaçãoCaption"; FieldCaption(Avaliação))
                {
                }
                column("Formação_Empregado_ObservaçõesCaption"; FieldCaption(Observações))
                {
                }
                column(TOTALCaption; TOTALCaptionLbl)
                {
                }
                column("Formação_Empregado_Cód__Acção"; "Cód. Acção")
                {
                }
                column("Formação_Empregado_Data_Início"; "Data Início")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if TabEmpregado.Get("Formação Empregado"."No. Empregado") then
                        Nome := TabEmpregado.Name;

                    TotalFormandos := TotalFormandos + 1
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(TotalFormandos);
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
        TabConfEmpresa.Get;
        TabConfEmpresa.CalcFields(Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total de ';
        TabConfEmpresa: Record "Company Information";
        DataInicio: Date;
        DataFim: Date;
        TabEmpregado: Record Employee;
        Nome: Text[250];
        TotalFormandos: Integer;
        "FORMAÇÃO_POR_ACÇÃOCaptionLbl": Label 'FORMAÇÃO POR ACÇÃO';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "AcçãoCaptionLbl": Label 'Acção';
        N__HorasCaptionLbl: Label 'Nº Horas';
        EmpregadoCaptionLbl: Label 'Empregado';
        TOTALCaptionLbl: Label 'Total Participantes';
}

