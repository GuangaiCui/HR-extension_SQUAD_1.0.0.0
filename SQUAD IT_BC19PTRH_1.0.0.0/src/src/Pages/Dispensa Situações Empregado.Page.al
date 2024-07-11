#pragma implicitwith disable
page 53137 "Dispensa Situações Empregado"
{
    PageType = List;
    SourceTable = "Dispensa Sit - Cargos Empregad";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cód. Dispensa"; Rec."Cód. Dispensa")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Nº Horas Sem. Contrato"; Rec."Nº Horas Sem. Contrato")
                {
                    ApplicationArea = All;

                }
                field("Nº Horas Sem. Totais"; Rec."Nº Horas Sem. Totais")
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

#pragma implicitwith restore

