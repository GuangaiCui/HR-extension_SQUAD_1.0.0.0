page 31003128 "Profissionalização"
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
                field("Cod Empregado"; "Cod Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Início"; "Data Início")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; "Data Fim")
                {
                    ApplicationArea = All;

                }
                field("No. Horas Profissionalização"; "No. Horas Profissionalização")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Classificação"; Classificação)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(Employee.Get("Cod Empregado"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Cod Empregado" := GetFilter("Cod Empregado");
    end;

    var
        Employee: Record Empregado;
}

