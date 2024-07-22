#pragma implicitwith disable
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
                field("No. Mov."; Rec."No. Mov.")
                {
                    ApplicationArea = All;
                }
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;
                }
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;
                }
                field("Cód. Hora Extra"; Rec."Cód. Hora Extra")
                {
                    ApplicationArea = All;
                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;
                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {
                    ApplicationArea = All;
                }
                field(Quantidade; Rec.Quantidade)
                {
                    ApplicationArea = All;
                }
                field(Factor; Rec.Factor)
                {
                    ApplicationArea = All;
                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ApplicationArea = All;
                }
                field("Comentário"; Rec."Comentário")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
        if Rec."Hora Extra Bloqueada" = true then    //HG 23.01.08
            Message(Text0001);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin


        exit(Employee.Get(Rec."No. Empregado"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //HG
        Rec."No. Empregado" := Rec.GetFilter("No. Empregado");
    end;

    var
        Text0001: Label 'Esta Hora Extra já foi processada, será necessário refazer o processamento para este empregado.';
        Employee: Record Employee;
        recPeriodosProcessamento: Record "Periodos Processamento";
        Text0002: Label 'Não pode apagar o registo de Hora Extra %1, porque o mês já se encontra fechado.';
}

#pragma implicitwith restore

