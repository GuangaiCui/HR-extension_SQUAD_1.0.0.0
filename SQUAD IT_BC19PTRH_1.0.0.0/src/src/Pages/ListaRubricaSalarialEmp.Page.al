page 31003101 "Lista Rubrica Salarial Emp."
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
                field("No. Empregado"; "No. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Rúbrica Salarial"; "Cód. Rúbrica Salarial")
                {
                    ApplicationArea = All;

                }
                field("Tipo Rubrica"; "Tipo Rubrica")
                {
                    ApplicationArea = All;

                }
                field("Descrição Rubrica"; "Descrição Rubrica")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Debitar"; "No. Conta a Debitar")
                {
                    ApplicationArea = All;

                }
                field("No. Conta a Creditar"; "No. Conta a Creditar")
                {
                    ApplicationArea = All;

                }
                field(Quantidade; Quantidade)
                {
                    ApplicationArea = All;

                }
                field("Valor Unitário"; "Valor Unitário")
                {
                    ApplicationArea = All;

                }
                field("Valor Total"; "Valor Total")
                {
                    ApplicationArea = All;

                }
                field("Data Início"; "Data Início")
                {
                    ApplicationArea = All;

                }
                field("Data Fim"; "Data Fim")
                {
                    ApplicationArea = All;

                }
                field("Ordenação"; Ordenação)
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

        if TabEmpregado.Get("No. Empregado") then begin
            if TabRubricaSalarial.Get("Cód. Rúbrica Salarial") then begin

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

