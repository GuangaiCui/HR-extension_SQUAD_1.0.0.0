#pragma implicitwith disable
page 53052 "Contratos Trabalho"
{
    Caption = 'Employment Contracts';
    PageType = List;
    SourceTable = "Contrato Trabalho";
    UsageCategory = Administration;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {


                }
                field(Description; Rec.Description)
                {


                }
                field("Tipo Contrato"; Rec."Tipo Contrato")
                {


                }
                field("Cód. Tipo Contrato"; Rec."Cód. Tipo Contrato")
                {


                }
                field("No. of Contracts"; Rec."No. of Contracts")
                {


                }
                field("Template Contrato"; Rec."Template Contrato")
                {


                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            //VC.MIG.S
            /*
            action("&Visualizar")
            {
              

                Caption = '&View';
                Image = View;

                trigger OnAction()
                begin
                    Rec.VisualizarContrato;
                end;
            }*/
            //VC.MIG.E
            action("&Importar")
            {


                Caption = '&Importar';
                Image = Import;

                trigger OnAction()
                begin
                    Rec.ImportarContrato;
                end;
            }
            action("&Exportar")
            {


                Caption = '&Exportar';
                Image = Export;

                trigger OnAction()
                begin
                    Rec.ExportarContrato;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        //HG 11.07.05
        //Isto serve para filtrar os contratos para que só apareçam os que estão em vigor
        //ou seja, os que têm a data de inicio de contrato anterior à Workdate
        // e que têm a data de fim de contrato posterior à workdate
        Rec.SetFilter("Data Filtro Inicio", '<=%1', WorkDate);
        Rec.SetFilter("Data Filtro Fim", '>=%1|=%2', WorkDate, 0D);
        //HG - Fim
    end;
}

#pragma implicitwith restore

