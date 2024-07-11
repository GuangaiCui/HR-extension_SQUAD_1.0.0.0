#pragma implicitwith disable
page 53152 "Doenças Profissionais"
{
    PageType = List;
    SourceTable = "Doenças Profissionais";

    layout
    {
        area(content)
        {
            repeater(Control1102065000)
            {
                ShowCaption = false;
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Data Participação"; Rec."Data Participação")
                {
                    ApplicationArea = All;

                }
                field("Factor Risco"; Rec."Factor Risco")
                {
                    ApplicationArea = All;

                }
                field("Designação Factor Risco"; Rec."Designação Factor Risco")
                {
                    ApplicationArea = All;

                }
                field("Doença Profissional"; Rec."Doença Profissional")
                {
                    ApplicationArea = All;

                }
                field("Designação Doença Profissional"; Rec."Designação Doença Profissional")
                {
                    ApplicationArea = All;

                }
                field("Data Confirmação"; Rec."Data Confirmação")
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

