#pragma implicitwith disable
page 53146 "Acções Médicas"
{
    PageType = Card;
    SourceTable = "Cab. Acções Médicas";
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group(Geral)
            {
                Caption = 'Geral';
                field("Entry No."; Rec."Entry No.")
                {


                    Editable = false;
                }
                field("Exam Type"; Rec."Exam Type")
                {



                    trigger OnValidate()
                    begin
                        CamposEnabled;
                    end;
                }
                field("Code"; Rec.Code)
                {


                    Enabled = CodigoEnable;
                }
                field(Description; Rec.Description)
                {


                    Enabled = CodigoEnable;
                }
                field(Reason; Rec.Reason)
                {


                    Enabled = MotivoEnable;
                }
            }
            part(Control1000000000; "Linhas Acções Médicas")
            {


                SubPageLink = "Entry No." = FIELD("Entry No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Acções Médicas")
            {
                Caption = 'Acções Médicas';
                separator(Action1102065019)
                {
                }
                action("Ex. Complementares - Factor Risco")
                {


                    Caption = 'Ex. Complementares - Factor Risco';
                    Image = Warning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Factores Risco - Exames";
                    RunPageLink = "Entry No." = FIELD("Entry No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CamposEnabled;
    end;

    trigger OnInit()
    begin
        MotivoEnable := true;
        CodigoEnable := true;
    end;

    trigger OnOpenPage()
    begin
        CamposEnabled;
    end;

    var

        MotivoEnable: Boolean;
        CodigoEnable: Boolean;

    procedure CamposEnabled()
    begin
        if Rec."Exam Type" = Rec."Exam Type"::"Exame Admissão" then begin
            CodigoEnable := false;
            MotivoEnable := false;
        end;

        if Rec."Exam Type" = Rec."Exam Type"::"Exame Periódico" then begin
            CodigoEnable := false;
            MotivoEnable := false;
        end;

        if Rec."Exam Type" = Rec."Exam Type"::"Exame Ocasional" then begin
            CodigoEnable := false;
            MotivoEnable := true;
        end;

        if Rec."Exam Type" = Rec."Exam Type"::"Exame Complementar" then begin
            CodigoEnable := true;
            MotivoEnable := false;
        end;

        if Rec."Exam Type" = Rec."Exam Type"::"Acções Imunização" then begin
            CodigoEnable := true;
            MotivoEnable := false;

        end;
    end;
}

#pragma implicitwith restore

