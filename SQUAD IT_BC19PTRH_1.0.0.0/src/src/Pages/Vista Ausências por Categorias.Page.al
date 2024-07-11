#pragma implicitwith disable
page 53066 "Vista Ausências por Categorias"
{
    Caption = 'Absence Overview by Categories';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = Empregado;
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group("Opções")
            {
                Caption = 'Options';
                field(EmployeeNoFilter; EmployeeNoFilter)
                {
                    ApplicationArea = All;

                    Caption = 'Employee No. Filter';
                    TableRelation = Empregado;
                }
            }
            group("Opções de Matriz")
            {

                Caption = 'Matrix Options';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = All;

                    Caption = 'View by';
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';

                    trigger OnValidate()
                    begin
                        MATRIX_GenerateColumnCaptions(SetWanted::Initial);
                    end;
                }
                field(AbsenceAmountType; AbsenceAmountType)
                {
                    ApplicationArea = All;

                    Caption = 'Amount Type';
                    OptionCaption = 'Net Change,Balance at Date';
                }
                field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                {
                    ApplicationArea = All;

                    Caption = 'Column Set';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowMatrix)
            {
                ApplicationArea = All;

                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MatrixForm: Page "Matriz de Vista Aus. por Cate.";
                begin
                    MatrixForm.Load(MATRIX_CaptionSet, MatrixRecords, PeriodType, AbsenceAmountType, EmployeeNoFilter);
                    MatrixForm.RunModal;
                end;
            }
            action("Conjunto Anterior")
            {
                ApplicationArea = All;

                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(SetWanted::Previous);
                end;
            }
            action("Conjunto Seguinte")
            {
                ApplicationArea = All;

                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(SetWanted::Next);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        MATRIX_GenerateColumnCaptions(SetWanted::Initial);
        if Rec.HasFilter then
            EmployeeNoFilter := Rec.GetFilter("Employee No. Filter");
    end;

    var
        MatrixRecord: Record "Absence Reason";
        MatrixRecords: array[32] of Record "Absence Reason";
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AbsenceAmountType: Option "Balance at Date","Net Change";
        MATRIX_CaptionSet: array[32] of Text[1024];
        EmployeeNoFilter: Text[250];
        PKFirstRecInCurrSet: Text[1024];
        MATRIX_CaptionRange: Text[1024];
        MatrixCaptions: Integer;
        SetWanted: Option Initial,Previous,Same,Next;


    procedure MatrixUpdate(NewAbsenceType: Option "Absence to Date","Absence at Date"; NewPeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period"; NewEmployeeNoFilter: Text[250])
    begin
        AbsenceAmountType := NewAbsenceType;
        PeriodType := NewPeriodType;
        EmployeeNoFilter := NewEmployeeNoFilter;
    end;


    procedure MATRIX_GenerateColumnCaptions(SetWanted: Option First,Previous,Same,Next)
    var
        CurrentMatrixRecordOrdinal: Integer;
        RecRef: RecordRef;
        MatrixMgt: Codeunit "Matrix Management";
    begin
        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;
        RecRef.GetTable(MatrixRecord);
        RecRef.SetTable(MatrixRecord);

        MatrixMgt.GenerateMatrixData(RecRef, SetWanted, ArrayLen(MatrixRecords), 1, PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MatrixCaptions);
        if MatrixCaptions > 0 then begin
            MatrixRecord.SetPosition(PKFirstRecInCurrSet);
            MatrixRecord.Find;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MatrixCaptions) or (MatrixRecord.Next <> 1);
        end;
    end;
}

#pragma implicitwith restore

