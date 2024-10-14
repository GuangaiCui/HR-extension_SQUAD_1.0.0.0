#pragma implicitwith disable
page 53101 "Lista Rubrica Salarial Emp."
{
    AutoSplitKey = true;
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Rubrica Salarial Empregado";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1101490000)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {


                }
                field("Cód. Rúbrica Salarial"; Rec."Cód. Rúbrica Salarial")
                {


                }
                field("Payroll Item Type"; Rec."Payroll Item Type")
                {


                }
                field("Payroll Item Description"; Rec."Payroll Item Description")
                {


                }
                field("Debit Acc. No."; Rec."Debit Acc. No.")
                {


                }
                field("Credit Acc. No."; Rec."Credit Acc. No.")
                {


                }
                field(Quantity; Rec.Quantity)
                {


                }
                field("Unit Value"; Rec."Unit Value")
                {


                }
                field("Total Amount"; Rec."Total Amount")
                {


                }
                field("Data Início"; Rec."Data Início")
                {


                }
                field("Data Fim"; Rec."Data Fim")
                {


                }
                field("Ordenação"; Rec.Sort)
                {


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

        if TabEmpregado.Get(Rec."Employee No.") then begin
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
        TabRubricaSalarial: Record "Payroll Item";
        Text0001: Label 'Não pode parametrizar uma Rúbrica do tipo Seg. Social, pois este empregado não é Subscritor.';
        Text0002: Label 'Não pode parametrizar uma Rúbrica do tipo CGA, pois este empregado não é Subscritor.';
        Text0003: Label 'Não pode parametrizar uma Rúbrica do tipo IVA, pois este empregado é da Cat. A.';
}

#pragma implicitwith restore

