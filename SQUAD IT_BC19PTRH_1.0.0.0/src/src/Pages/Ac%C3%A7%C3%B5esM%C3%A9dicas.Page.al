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
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Exam Type"; "Exam Type")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        CamposEnabled;
                    end;
                }
                field("Code"; Code)
                {
                    ApplicationArea = All;

                    Enabled = CodigoEnable;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                    Enabled = CodigoEnable;
                }
                field(Reason; Reason)
                {
                    ApplicationArea = All;

                    Enabled = MotivoEnable;
                }
            }
            part(Control1000000000; "Linhas Acções Médicas")
            {
                ApplicationArea = All;

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
                    ApplicationArea = All;

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
        [InDataSet]
        MotivoEnable: Boolean;
        CodigoEnable: Boolean;

    procedure CamposEnabled()
    begin
        if "Exam Type" = "Exam Type"::"Exame Admissão" then begin
            CodigoEnable := false;
            MotivoEnable := false;
        end;

        if "Exam Type" = "Exam Type"::"Exame Periódico" then begin
            CodigoEnable := false;
            MotivoEnable := false;
        end;

        if "Exam Type" = "Exam Type"::"Exame Ocasional" then begin
            CodigoEnable := false;
            MotivoEnable := true;
        end;

        if "Exam Type" = "Exam Type"::"Exame Complementar" then begin
            CodigoEnable := true;
            MotivoEnable := false;
        end;

        if "Exam Type" = "Exam Type"::"Acções Imunização" then begin
            CodigoEnable := true;
            MotivoEnable := false;

        end;
    end;
}

