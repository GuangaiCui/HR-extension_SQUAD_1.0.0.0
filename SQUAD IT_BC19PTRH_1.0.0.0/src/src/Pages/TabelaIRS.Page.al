#pragma implicitwith disable
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
                field(Ano; Rec.Ano)
                {
                    ;

                }
                field(Tabela; Rec.Tabela)
                {
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field(Valor; Rec.Valor)
                {
                    ;

                }
                field("TD 0 Dependentes"; Rec."TD 0 Dependentes")
                {
                    ;

                    Caption = '0';
                }
                field("TD 1 Dependentes"; Rec."TD 1 Dependentes")
                {
                    ;

                    Caption = '1';
                }
                field("TD 2 Dependentes"; Rec."TD 2 Dependentes")
                {
                    ;

                    Caption = '2';
                }
                field("TD 3 Dependentes"; Rec."TD 3 Dependentes")
                {
                    ;

                    Caption = '3';
                }
                field("TD 4 Dependentes"; Rec."TD 4 Dependentes")
                {
                    ;

                    Caption = '4';
                }
                field("TD 5ou Mais Dependentes"; Rec."TD 5ou Mais Dependentes")
                {
                    ;

                    Caption = '5 ou Mais';
                }
                field(PenCas2Tit; Rec.PenCas2Tit)
                {
                    ;

                    Caption = 'Pensões Casado 2 Titulares';
                }
                field(PenNCas; Rec.PenNCas)
                {
                    ;

                    Caption = 'Pensões Não Casado';
                }
                field(PenCas1Tit; Rec.PenCas1Tit)
                {
                    ;

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
                ;

                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = XMLport "Tabelas IRS";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        txtValor := Rec."Até" + ' ' + Format(Rec.Valor);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Região, 0);
        Rec.SetRange(Ano, Date2DMY(Today, 3));
    end;

    var
        txtValor: Text[60];
        Descricao: Text[100];
        TabelaIRS: Record "Tabela IRS";
        Regiao: Text[100];
        varAno: Text[30];
        Text19059037: Label 'Número de Dependentes';
}

#pragma implicitwith restore

