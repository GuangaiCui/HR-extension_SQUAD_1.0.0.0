#pragma implicitwith disable
page 53167 "Seg Saude Empregado"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Seguro Saude Empregado";
    ApplicationArea = HumanResourcesAppArea;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("Nome Empregado"; Rec."Nome Empregado")
                {


                }
                field("No. Seguro"; Rec."No. Seguro")
                {


                }
                field(Parentesco; Rec.Parentesco)
                {


                }
                field("Nome Beneficiário"; Rec."Nome Beneficiário")
                {


                }
                field("Data Inclusão"; Rec."Data Inclusão")
                {


                }
                field("Data Exclusão"; Rec."Data Exclusão")
                {


                }
                field(Tipo; Rec.Tipo)
                {


                }
                field("Valor Anual"; Rec."Valor Anual")
                {


                }
                field("Valor Suportado pela Empresa"; Rec."Valor Suportado pela Empresa")
                {


                }
                field("Valor Suportado pelo Colab."; Rec."Valor Suportado pelo Colab.")
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

