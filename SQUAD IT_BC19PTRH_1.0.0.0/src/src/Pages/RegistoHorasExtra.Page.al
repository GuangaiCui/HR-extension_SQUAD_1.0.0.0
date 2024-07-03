page 53090 "Registo Horas Extra"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Horas Extra Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Mov."; "No. Mov.")
                {
                    ApplicationArea = All;
                }
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;
                }
                field(Data; Data)
                {
                    ApplicationArea = All;
                }
                field("Cód. Hora Extra"; "Cód. Hora Extra")
                {
                    ApplicationArea = All;
                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;
                }
                field("Cód. Rubrica"; "Cód. Rubrica")
                {
                    ApplicationArea = All;
                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;
                }
                field(Factor; Factor)
                {
                    ApplicationArea = All;
                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;
                }
                field("Comentário"; Comentário)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000001; Links)
            {
                Visible = false;
            }
            systempart(Control1000000000; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Hora E&xtra")
            {
                action("Comentários")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(HorEx),
                                  "Table Line No." = FIELD("No. Mov.");
                }
                action("Horas Extra Colectiva")
                {
                    Caption = 'Horas Extra Colectiva';
                    Image = ServiceHours;

                    trigger OnAction()
                    begin
                        REPORT.RunModal(53036);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        if "Hora Extra Bloqueada" = true then    //HG 23.01.08
            Message(Text0001);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin


        exit(Employee.Get("No. Empregado"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //HG
        "No. Empregado" := GetFilter("No. Empregado");
    end;

    var
        Text0001: Label 'Esta Hora Extra já foi processada, será necessário refazer o processamento para este empregado.';
        Employee: Record Empregado;
        recPeriodosProcessamento: Record "Periodos Processamento";
        Text0002: Label 'Não pode apagar o registo de Hora Extra %1, porque o mês já se encontra fechado.';
}

