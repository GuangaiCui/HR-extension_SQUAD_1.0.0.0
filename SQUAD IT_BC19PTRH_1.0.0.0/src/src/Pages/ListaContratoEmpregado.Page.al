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
                    ;

                }
                field("Cód. Contrato"; Rec."Cód. Contrato")
                {
                    ;

                }
                field("Descrição"; Rec."Descrição")
                {
                    ;

                }
                field("Tipo Contrato"; Rec."Tipo Contrato")
                {
                    ;

                }
                field("Duração Contrato"; Rec."Duração Contrato")
                {
                    ;

                }
                field("Data Inicio Contrato"; Rec."Data Inicio Contrato")
                {
                    ;

                }
                field("Data Fim Contrato"; Rec."Data Fim Contrato")
                {
                    ;

                }
                field("Motivo Entrada"; Rec."Motivo Entrada")
                {
                    ;

                }
                field("Comentário"; Rec."Comentário")
                {
                    ;

                }
                field("Ficheiro Contrato Trabalho"; Rec."Ficheiro Contrato Trabalho")
                {
                    ;

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
                    ;

                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Folha Comentários RH";
                    RunPageLink = "Table Name" = CONST(Cont),
                                  "No." = FIELD("Cód. Empregado"),
                                  "Table Line No." = FIELD("No. Linha");
                }
                action("Criar Contrato Conforme Template")
                {
                    ;

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
                    ;

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
                //VC_MIG
                /*NOTES: deleted because is not longer supported oon this version
                action(Visualizar)
                {
                     ;

                    Caption = 'Visualizar';
                    Image = View;

                    trigger OnAction()
                    begin
                        Rec.VisualizarContrato;
                    end;
                }
                */
                //VC_MIG
                action(Exportar)
                {
                    ;

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

