#pragma implicitwith disable
page 53072 "Lista Contrato Empregado"
{
    AutoSplitKey = true;
    Caption = 'Employee Relatives';
    DataCaptionFields = "Cód. Empregado";
    PageType = List;
    SourceTable = "Contrato Empregado";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Cód. Empregado"; Rec."Cód. Empregado")
                {
                    ApplicationArea = All;

                }
                field("Cód. Contrato"; Rec."Cód. Contrato")
                {
                    ApplicationArea = All;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ApplicationArea = All;

                }
                field("Tipo Contrato"; Rec."Tipo Contrato")
                {
                    ApplicationArea = All;

                }
                field("Duração Contrato"; Rec."Duração Contrato")
                {
                    ApplicationArea = All;

                }
                field("Data Inicio Contrato"; Rec."Data Inicio Contrato")
                {
                    ApplicationArea = All;

                }
                field("Data Fim Contrato"; Rec."Data Fim Contrato")
                {
                    ApplicationArea = All;

                }
                field("Motivo Entrada"; Rec."Motivo Entrada")
                {
                    ApplicationArea = All;

                }
                field("Comentário"; Rec."Comentário")
                {
                    ApplicationArea = All;

                }
                field("Ficheiro Contrato Trabalho"; Rec."Ficheiro Contrato Trabalho")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Contrato Empregado")
            {
                Caption = '&Relative';
                action("Co&mentários")
                {
                    ApplicationArea = All;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Cont),
                                  "No." = FIELD("Cód. Empregado"),
                                  "Table Line No." = FIELD("No. Linha");
                }
                action("Criar Contrato Conforme Template")
                {
                    ApplicationArea = All;

                    Caption = 'Criar Contrato Conforme Template';
                    Image = ContractPayment;

                    trigger OnAction()
                    begin
                        Rec.CriarContratoConformeTemplate;
                        Commit;
                        Message(Text0001);
                    end;
                }
                action("Importar Contratos Digitalizados")
                {
                    ApplicationArea = All;

                    Caption = 'Importar Contratos Digitalizados';
                    Image = Import;

                    trigger OnAction()
                    begin

                        Rec.ImportarContrato;
                    end;
                }
                separator(Action1102065003)
                {
                }
                action(Visualizar)
                {
                    ApplicationArea = All;

                    Caption = 'Visualizar';
                    Image = View;

                    trigger OnAction()
                    begin
                        Rec.VisualizarContrato;
                    end;
                }
                action(Exportar)
                {
                    ApplicationArea = All;

                    Caption = 'Exportar';
                    Image = Export;

                    trigger OnAction()
                    begin

                        Rec.ExportarContrato;
                    end;
                }
            }
        }
    }

    var
        Text0001: Label 'Finish.';


    procedure Cliente(inCliente: Code[20])
    begin

        Rec."Cod. Cliente" := inCliente;
    end;
}

#pragma implicitwith restore

