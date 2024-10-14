#pragma implicitwith disable
page 53137 "Dispensa Situações Empregado"
{
    PageType = List;
    SourceTable = "Dispensa Sit - Cargos Empregad";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cód. Dispensa"; Rec."Cód. Dispensa")
                {


                }
                field("Descrição"; Rec."Descrição")
                {


                }
                field("Nº Horas Sem. Contrato"; Rec."Nº Horas Sem. Contrato")
                {


                }
                field("Nº Horas Sem. Totais"; Rec."Nº Horas Sem. Totais")
                {


                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

