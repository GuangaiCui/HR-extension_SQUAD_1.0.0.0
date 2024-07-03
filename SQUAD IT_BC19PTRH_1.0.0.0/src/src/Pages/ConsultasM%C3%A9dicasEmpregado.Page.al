page 31003122 "Consultas Médicas Empregado"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Consultas Médicas Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Consulta"; "Data Consulta")
                {
                    ApplicationArea = All;

                }
                field("Data Próxima Consulta"; "Data Próxima Consulta")
                {
                    ApplicationArea = All;

                }
                field(Resultado; Resultado)
                {
                    ApplicationArea = All;

                }
                field("No. de Diagnóstico"; "No. de Diagnóstico")
                {
                    ApplicationArea = All;

                }
                field("Observações"; Observações)
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
        //HG
        exit(Employee.Get("No. Empregado"));
    end;

    var
        Employee: Record Empregado;
}

