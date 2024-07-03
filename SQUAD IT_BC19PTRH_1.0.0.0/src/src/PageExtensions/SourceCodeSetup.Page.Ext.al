pageextension 31003039 SourceCodeSetupRH extends "Source Code Setup"
{
    layout
    {
        addlast(content)
        {
            group("Human Resources")

            {
                CaptionML = ENU = 'Human Resources', PTG = 'Recursos Humanos';

                field("Integração Vencimentos"; Rec."Integração Vencimentos")
                {
                    ApplicationArea = All;

                }

                field("Pagamento Vencimentos"; Rec."Pagamento Vencimentos")
                {
                    ApplicationArea = All;

                }
            }
        }

    }
}

