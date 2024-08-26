#pragma implicitwith disable
page 53128 "Profissionalização"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Profissionalização";

    layout
    {
        area(content)
        {
            repeater(Control1102056000)
            {
                ShowCaption = false;
                field("Cod Empregado"; Rec."Cod Empregado")
                {


                }
                field("Data Início"; Rec."Data Início")
                {


                }
                field("Data Fim"; Rec."Data Fim")
                {


                }
                field("No. Horas Profissionalização"; Rec."No. Horas Profissionalização")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("Classificação"; Rec."Classificação")
                {


                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(Employee.Get(Rec."Cod Empregado"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Cod Empregado" := Rec.GetFilter("Cod Empregado");
    end;

    var
        Employee: Record Employee;
}

#pragma implicitwith restore

