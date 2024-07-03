page 31003167 "Seg Saude Empregado"
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
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Nome Empregado"; "Nome Empregado")
                {
                    ApplicationArea = All;

                }
                field("No. Seguro"; "No. Seguro")
                {
                    ApplicationArea = All;

                }
                field(Parentesco; Parentesco)
                {
                    ApplicationArea = All;

                }
                field("Nome Beneficiário"; "Nome Beneficiário")
                {
                    ApplicationArea = All;

                }
                field("Data Inclusão"; "Data Inclusão")
                {
                    ApplicationArea = All;

                }
                field("Data Exclusão"; "Data Exclusão")
                {
                    ApplicationArea = All;

                }
                field(Tipo; Tipo)
                {
                    ApplicationArea = All;

                }
                field("Valor Anual"; "Valor Anual")
                {
                    ApplicationArea = All;

                }
                field("Valor Suportado pela Empresa"; "Valor Suportado pela Empresa")
                {
                    ApplicationArea = All;

                }
                field("Valor Suportado pelo Colab."; "Valor Suportado pelo Colab.")
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

