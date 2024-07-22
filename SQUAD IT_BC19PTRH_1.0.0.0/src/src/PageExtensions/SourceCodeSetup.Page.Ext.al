pageextension 53039 SourceCodeSetupRH extends "Source Code Setup"
{
    layout
    {
        addlast(content)
        {
            group("Human Resources")

            {
                Caption = 'Human Resources';

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

