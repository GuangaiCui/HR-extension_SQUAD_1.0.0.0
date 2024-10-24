report 53058 "Empregado - Etiquetas"
{
    // //-------------------------------------------------------
    //               Empregado - Etiquetas
    // //--------------------------------------------------------
    //   É um Mapa para listar o Nome, Morada e Código Postal
    //   de cada empregado para ser impresso em etiquetas.
    //   Este Report está disponível a partir de Mapas.
    // //-------------------------------------------------------
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = HumanResourcesAppArea;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\EmpregadoEtiquetas.rdl';

    Caption = 'Employee - Labels';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            RequestFilterFields = "No.", "First Name", "Last Name";
            column(EmployeeAddr_1__1_; EmployeeAddr[1] [1])
            {
            }
            column(EmployeeAddr_1__2_; EmployeeAddr[1] [2])
            {
            }
            column(EmployeeAddr_1__3_; EmployeeAddr[1] [3])
            {
            }
            column(EmployeeAddr_1__4_; EmployeeAddr[1] [4])
            {
            }
            column(EmployeeAddr_1__5_; EmployeeAddr[1] [5])
            {
            }
            column(EmployeeAddr_1__6_; EmployeeAddr[1] [6])
            {
            }
            column(EmployeeAddr_2__1_; EmployeeAddr[2] [1])
            {
            }
            column(EmployeeAddr_2__2_; EmployeeAddr[2] [2])
            {
            }
            column(EmployeeAddr_2__3_; EmployeeAddr[2] [3])
            {
            }
            column(EmployeeAddr_2__4_; EmployeeAddr[2] [4])
            {
            }
            column(EmployeeAddr_2__5_; EmployeeAddr[2] [5])
            {
            }
            column(EmployeeAddr_2__6_; EmployeeAddr[2] [6])
            {
            }
            column(EmployeeAddr_3__1_; EmployeeAddr[3] [1])
            {
            }
            column(EmployeeAddr_3__2_; EmployeeAddr[3] [2])
            {
            }
            column(EmployeeAddr_3__3_; EmployeeAddr[3] [3])
            {
            }
            column(EmployeeAddr_3__4_; EmployeeAddr[3] [4])
            {
            }
            column(EmployeeAddr_3__5_; EmployeeAddr[3] [5])
            {
            }
            column(EmployeeAddr_3__6_; EmployeeAddr[3] [6])
            {
            }
            column(EmployeeAddr_1__7_; EmployeeAddr[1] [7])
            {
            }
            column(EmployeeAddr_1__8_; EmployeeAddr[1] [8])
            {
            }
            column(EmployeeAddr_2__7_; EmployeeAddr[2] [7])
            {
            }
            column(EmployeeAddr_2__8_; EmployeeAddr[2] [8])
            {
            }
            column(EmployeeAddr_3__7_; EmployeeAddr[3] [7])
            {
            }
            column(EmployeeAddr_3__8_; EmployeeAddr[3] [8])
            {
            }
            column(Empregado_No_; "No.")
            {
            }
            column(ColumnNo; ColumnNo)
            {
            }
            column(LabelFormat; Format(LabelFormat, 0, 9))
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordNo := RecordNo + 1;
                ColumnNo := ColumnNo + 1;
                if (Today < Empregado."Alt. Address End Date") and
                   (Today > Empregado."Alt. Address Start Date") and
                   (Empregado."Alt. Address Code" <> '') and
                   (AddrFormat = AddrFormat::"Current Alternative Address")
                then
                    FormatAddr.FormatAddressEmpregadoAltAddr(EmployeeAddr[ColumnNo], Empregado)
                else
                    FormatAddr.FormatAddressEmpregado(EmployeeAddr[ColumnNo], Empregado);
                if RecordNo = NoOfRecords then begin
                    for i := ColumnNo + 1 to NoOfColumns do
                        Clear(EmployeeAddr[i]);
                    ColumnNo := 0;
                end else begin
                    if ColumnNo = NoOfColumns then
                        ColumnNo := 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                case LabelFormat of
                    LabelFormat::"36 x 70 mm (3 columns)", LabelFormat::"37 x 70 mm (3 columns)":
                        NoOfColumns := 3;
                    LabelFormat::"36 x 105 mm (2 columns)", LabelFormat::"37 x 105 mm (2 columns)":
                        NoOfColumns := 2;
                end;
                NoOfRecords := Count;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AddrFormat; AddrFormat)
                {
                    ApplicationArea = HumanResourcesAppArea;
                    ShowCaption = false;
                }
                field(LabelFormat; LabelFormat)
                {
                    ApplicationArea = HumanResourcesAppArea;
                    ShowCaption = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        FormatAddr: Codeunit "Funções RH";
        LabelFormat: Option "36 x 70 mm (3 columns)","37 x 70 mm (3 columns)","36 x 105 mm (2 columns)","37 x 105 mm (2 columns)";
        AddrFormat: Option "Home Address","Current Alternative Address";
        EmployeeAddr: array[3, 8] of Text[75];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
}

