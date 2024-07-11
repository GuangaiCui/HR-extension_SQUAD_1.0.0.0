#pragma implicitwith disable
page 53167 "Seg Saude Empregado"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Seguro Saude Empregado";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Nome Empregado"; Rec."Nome Empregado")
                {
                    ApplicationArea = All;

                }
                field("No. Seguro"; Rec."No. Seguro")
                {
                    ApplicationArea = All;

                }
                field(Parentesco; Rec.Parentesco)
                {
                    ApplicationArea = All;

                }
                field("Nome Beneficiário"; Rec."Nome Beneficiário")
                {
                    ApplicationArea = All;

                }
                field("Data Inclusão"; Rec."Data Inclusão")
                {
                    ApplicationArea = All;

                }
                field("Data Exclusão"; Rec."Data Exclusão")
                {
                    ApplicationArea = All;

                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;

                }
                field("Valor Anual"; Rec."Valor Anual")
                {
                    ApplicationArea = All;

                }
                field("Valor Suportado pela Empresa"; Rec."Valor Suportado pela Empresa")
                {
                    ApplicationArea = All;

                }
                field("Valor Suportado pelo Colab."; Rec."Valor Suportado pelo Colab.")
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

