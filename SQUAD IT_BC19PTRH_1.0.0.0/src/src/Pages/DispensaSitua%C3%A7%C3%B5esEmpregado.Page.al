page 31003137 "Dispensa Situações Empregado"
{
    PageType = List;
    SourceTable = "Dispensa Sit - Cargos Empregad";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cód. Dispensa"; "Cód. Dispensa")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field("Nº Horas Sem. Contrato"; "Nº Horas Sem. Contrato")
                {
                    ApplicationArea = All;

                }
                field("Nº Horas Sem. Totais"; "Nº Horas Sem. Totais")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

