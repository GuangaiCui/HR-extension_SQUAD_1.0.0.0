#pragma implicitwith disable
page 53122 "Consultas Médicas Empregado"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Consultas Médicas Empregado";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("Data Consulta"; Rec."Data Consulta")
                {


                }
                field("Data Próxima Consulta"; Rec."Data Próxima Consulta")
                {


                }
                field(Resultado; Rec.Resultado)
                {


                }
                field("No. de Diagnóstico"; Rec."No. de Diagnóstico")
                {


                }
                field("Observações"; Rec."Observações")
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
        //HG
        exit(Employee.Get(Rec."Employee No."));
    end;

    var
        Employee: Record Empregado;
}

#pragma implicitwith restore

