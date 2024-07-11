#pragma implicitwith disable
page 53101 "Lista Rubrica Salarial Emp."
{
    AutoSplitKey = true;
    DataCaptionFields = "No. Empregado";
    DelayedInsert = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Rubrica Salarial Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("No. Empregado"; Rec."No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Salarial"; Rec."Cód. Rúbrica Salarial")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; Rec."Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica"; Rec."Descrição Rubrica")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Debitar"; Rec."No. Conta a Debitar")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Creditar"; Rec."No. Conta a Creditar")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Rec.Quantidade)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; Rec."Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field("Valor Total"; Rec."Valor Total")
                {
                    ApplicationArea = All;

                }
                field("Data Início"; Rec."Data Início")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; Rec."Data Fim")
                {
                    ApplicationArea = All;

                }
                field("Ordenação"; Rec."Ordenação")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Esta validação, impede que se parametrize:
        //uma rubrica SS se não for subscritor
        //uma rubrica CGA se não for subscritor
        //uma rubrica IVA se for Cat. A

        if TabEmpregado.Get(Rec."No. Empregado") then begin
            if TabRubricaSalarial.Get(Rec."Cód. Rúbrica Salarial") then begin

                //SS
                if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::SS) and
                   (TabEmpregado."Subscritor SS" = false) then begin
                    Message(Text0001);
                    exit(false);
                end;

                //CGA
                if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::CGA) and
                   (TabEmpregado."Subsccritor CGA" = false) then begin
                    Message(Text0002);
                    exit(false);
                end;

                //IVA
                if (TabRubricaSalarial.Genero = TabRubricaSalarial.Genero::IVA) and
                   (TabEmpregado."Tipo Rendimento" = TabEmpregado."Tipo Rendimento"::A) then begin
                    Message(Text0003);
                    exit(false);
                end;


            end;

        end;
    end;

    var
        TabEmpregado: Record Empregado;
        TabRubricaSalarial: Record "Rubrica Salarial";
        Text0001: Label 'Não pode parametrizar uma Rúbrica do tipo Seg. Social, pois este empregado não é Subscritor.';
        Text0002: Label 'Não pode parametrizar uma Rúbrica do tipo CGA, pois este empregado não é Subscritor.';
        Text0003: Label 'Não pode parametrizar uma Rúbrica do tipo IVA, pois este empregado é da Cat. A.';
}

#pragma implicitwith restore

