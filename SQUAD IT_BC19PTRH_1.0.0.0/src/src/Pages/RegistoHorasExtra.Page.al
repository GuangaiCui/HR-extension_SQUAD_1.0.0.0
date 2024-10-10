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
                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Employee No."; Rec."Employee No.")
                {

                }
                field(Data; Rec.Data)
                {

                }
                field("Cód. Hora Extra"; Rec."Cód. Hora Extra")
                {

                }
                field("Descrição"; Rec."Descrição")
                {

                }
                field("Cód. Rubrica"; Rec."Cód. Rubrica")
                {

                }
                field(Quantity; Rec.Quantity)
                {

                }
                field(Factor; Rec.Factor)
                {

                }
                field("Unit Value"; Rec."Unit Value")
                {

                }
                field("Comentário"; Rec."Comentário")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

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
                                  "Table Line No." = FIELD("Entry No.");
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


        exit(Employee.Get(Rec."Employee No."));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //HG
        Rec."Employee No." := Rec.GetFilter("Employee No.");
    end;

    var
        Text0001: Label 'Esta Hora Extra já foi processada, será necessário refazer o processamento para este empregado.';
        Employee: Record Empregado;
        recPeriodosProcessamento: Record "Periodos Processamento";
        Text0002: Label 'Não pode apagar o registo de Hora Extra %1, porque o mês já se encontra fechado.';
}

#pragma implicitwith restore

