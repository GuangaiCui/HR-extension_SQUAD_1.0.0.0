page 53047 "Registo Ausência"
{
    //  //CPA - Novo campo Novo Valor Ausencia

    Caption = 'Absence Registration';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Ausência Empregado";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;

                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;

                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;

                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = All;

                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;

                }
                field(Justificada; Justificada)
                {
                    ApplicationArea = All;

                }
                field("Com Perda de Remuneração"; "Com Perda de Remuneração")
                {
                    ApplicationArea = All;

                }
                field("Com Perda Sub. Alimentação"; "Com Perda Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Qtd. Perda Sub. Alimentação"; "Qtd. Perda Sub. Alimentação")
                {
                    ApplicationArea = All;

                }
                field("Influência Nº dias férias"; "Influência Nº dias férias")
                {
                    ApplicationArea = All;

                }
                field("Hora Inicio"; "Hora Inicio")
                {
                    ApplicationArea = All;

                }
                field("Hora Fim"; "Hora Fim")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Quantidade Pendente"; "Quantidade Pendente")
                {
                    ApplicationArea = All;

                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;

                }
                field("Novo Valor Ausencia"; "Novo Valor Ausencia")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;

                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;

                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("A&bsence")
            {
                Caption = '&Ausência';
                Image = Absence;
                action("Comentários")
                {
                    ApplicationArea = All;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Aus),
                                  "Table Line No." = FIELD("Entry No.");
                }
                action("Ausência Colectiva")
                {
                    ApplicationArea = All;

                    Caption = 'Ausência Colectiva';
                    Image = Absence;
                    RunObject = Report "Ausência Colectiva";
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin

        if "Ausência Bloqueada" = true then    //HG 23.01.08
            Message(Text0001);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(Employee.Get("Employee No."));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //HG
        "Employee No." := GetFilter("Employee No.");
        //HG
    end;

    var
        Employee: Record Empregado;
        VarAusenciaBloqueada: Record "Ausência Empregado";
        recPeriodosProcessamento: Record "Periodos Processamento";
        Text0001: Label 'Esta Ausência já foi processada, será necessário refazer o processamento para este empregado.';
        Text0002: Label 'Não pode apagar a ausência %1, porque o mês já se encontra fechado.';
}

