page 53085 "Tabela IRS"
{
    PageType = List;
    SourceTable = "Tabela IRS";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                Editable = false;
                ShowCaption = false;
                field(Ano; Ano)
                {
                    ApplicationArea = All;

                }
                field(Tabela; Tabela)
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Descrição)
                {
                    ApplicationArea = All;

                }
                field(Valor; Valor)
                {
                    ApplicationArea = All;

                }
                field("TD 0 Dependentes"; "TD 0 Dependentes")
                {
                    ApplicationArea = All;

                    Caption = '0';
                }
                field("TD 1 Dependentes"; "TD 1 Dependentes")
                {
                    ApplicationArea = All;

                    Caption = '1';
                }
                field("TD 2 Dependentes"; "TD 2 Dependentes")
                {
                    ApplicationArea = All;

                    Caption = '2';
                }
                field("TD 3 Dependentes"; "TD 3 Dependentes")
                {
                    ApplicationArea = All;

                    Caption = '3';
                }
                field("TD 4 Dependentes"; "TD 4 Dependentes")
                {
                    ApplicationArea = All;

                    Caption = '4';
                }
                field("TD 5ou Mais Dependentes"; "TD 5ou Mais Dependentes")
                {
                    ApplicationArea = All;

                    Caption = '5 ou Mais';
                }
                field(PenCas2Tit; PenCas2Tit)
                {
                    ApplicationArea = All;

                    Caption = 'Pensões Casado 2 Titulares';
                }
                field(PenNCas; PenNCas)
                {
                    ApplicationArea = All;

                    Caption = 'Pensões Não Casado';
                }
                field(PenCas1Tit; PenCas1Tit)
                {
                    ApplicationArea = All;

                    Caption = 'Pensões Casado 1Titular';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportarTabelasIRS)
            {
                ApplicationArea = All;

                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = XMLport "Tabelas IRS";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        txtValor := Até + ' ' + Format(Valor);
    end;

    trigger OnOpenPage()
    begin
        SetRange(Região, 0);
        SetRange(Ano, Date2DMY(Today, 3));
    end;

    var
        txtValor: Text[60];
        Descricao: Text[100];
        TabelaIRS: Record "Tabela IRS";
        Regiao: Text[100];
        varAno: Text[30];
        Text19059037: Label 'Número de Dependentes';
}

