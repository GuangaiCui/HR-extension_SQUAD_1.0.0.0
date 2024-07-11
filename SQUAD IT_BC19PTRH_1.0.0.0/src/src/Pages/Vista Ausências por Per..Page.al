#pragma implicitwith disable
page 53061 "Vista Ausências por Per."
{
    Caption = 'Absence Overview by Periods';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Employee;
    UsageCategory = Lists;
    ApplicationArea = HumanResourcesAppArea;

    layout
    {
        area(content)
        {
            group("Opções")
            {
                Caption = 'Options';
                field("Cause Of Absence Filter"; CauseOfAbsenceFilter)
                {
                    ApplicationArea = All;

                    Caption = 'Cause of Absence Filter';
                    TableRelation = "Cause of Absence";
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
                        SetColumns(SetWanted::Initial);
                    end;
                }
                field(QtyType; QtyType)
                {
                    ApplicationArea = All;

                    Caption = 'View as';
                    OptionCaption = 'Net Change,Balance at Date';
                }
                field(ColumnSet; ColumnSet)
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
                    AbsOverviewByPeriodMatrix: Page "Matriz de Vista Aus. p/ Per..";
                begin
                    AbsOverviewByPeriodMatrix.Load(MatrixColumnCaptions, MatrixRecords, CauseOfAbsenceFilter, QtyType);
                    AbsOverviewByPeriodMatrix.RunModal;
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
                    SetColumns(SetWanted::Previous);
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
                    SetColumns(SetWanted::Next);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetColumns(SetWanted::Initial);
        if Rec.HasFilter then
            CauseOfAbsenceFilter := Rec.GetFilter("Cause of Absence Filter");
    end;

    var
        MatrixRecords: array[32] of Record Date;
        QtyType: Option "Balance at Date","Net Change";
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        CauseOfAbsenceFilter: Code[10];
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        SetWanted: Option Initial,Previous,Same,Next;
        PKFirstRecInCurrSet: Text[100];
        CurrSetLength: Integer;


    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
    var
        MatrixMgt: Codeunit "Matrix Management";
    begin
        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 32, false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;
}

#pragma implicitwith restore

