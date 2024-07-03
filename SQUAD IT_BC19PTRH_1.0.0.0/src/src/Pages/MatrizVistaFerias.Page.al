page 53087 "Matriz Vista Ferias"
{
    Caption = 'Matriz Vista de Ferias';
    DataCaptionExpression = '';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = Empregado;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                FreezeColumn = "Full Name";
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Full Name"; FullName)
                {
                    ApplicationArea = All;

                    Caption = 'Full Name';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = All;

                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(32);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_NoOfColumns: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 1;
        MATRIX_NoOfColumns := ArrayLen(MATRIX_CellData);

        while MATRIX_CurrentColumnOrdinal <= MATRIX_NoOfColumns do begin
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
        end;
    end;

    var
        MatrixRecords: array[32] of Record Date;
        VacationAmountType: Option "Net Change","Balance at Date";
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_ColumnCaption: array[32] of Text[1024];
        CauseOfVacationFilter: Code[10];

    local procedure SetDateFilter(ColumnID: Integer)
    begin
        if VacationAmountType = VacationAmountType::"Net Change" then
            if MatrixRecords[ColumnID]."Period Start" = MatrixRecords[ColumnID]."Period End" then
                SetRange("Date Filter", MatrixRecords[ColumnID]."Period Start")
            else
                SetRange("Date Filter", MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End")
        else
            SetRange("Date Filter", 0D, MatrixRecords[ColumnID]."Period End");
    end;


    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record Date; CauseOfVacationFilter1: Code[10]; VacationAmountType1: Option "Balance at Date","Net Change")
    var
        i: Integer;
    begin
        CopyArray(MATRIX_ColumnCaption, MatrixColumns1, 1);
        for i := 1 to ArrayLen(MatrixRecords) do
            MatrixRecords[i].Copy(MatrixRecords1[i]);
        CauseOfVacationFilter := CauseOfVacationFilter1;
        VacationAmountType := VacationAmountType1;
    end;

    local procedure MatrixOnDrillDown(ColumnID: Integer)
    var
        EmployeeAbsence: Record "Férias Empregados";
    begin
        SetDateFilter(ColumnID);
        EmployeeAbsence.SetRange("No. Empregado", "No.");
        EmployeeAbsence.SetRange(Tipo, 0);
        SetFilter("Cause of Absence Filter", CauseOfVacationFilter);
        EmployeeAbsence.SetFilter(Data, Format("Date Filter"));
        PAGE.Run(0, EmployeeAbsence);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        SetFilter("Cause of Absence Filter", CauseOfVacationFilter);
        CalcFields("Total Férias");
        MATRIX_CellData[ColumnID] := "Total Férias";
    end;
}

