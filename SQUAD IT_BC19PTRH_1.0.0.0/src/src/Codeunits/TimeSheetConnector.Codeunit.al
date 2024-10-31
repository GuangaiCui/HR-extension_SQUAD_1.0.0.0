codeunit 53044 TimeSheetConnector
{
    #region TABLE INSERTION PROCEDURES
    procedure InsertTimeSheetDetail(EmpregadoNo: Code[20]; Date: Date; JobNo: Code[20]; jobDescription: text; Hours: Decimal): Boolean
    var
        timeSheetDetail: Record "Time Sheet Detail";
        job: Record Job;
    begin
        if not job.Get(JobNo) then begin
            if not InsertProject(JobNo, jobDescription) then begin
                exit(false);
            end;
        end;

        timeSheetDetail.Init();
        timeSheetDetail."Job No." := JobNo;
        timeSheetDetail."Resource No." := EmpregadoNo;
        timeSheetDetail.Date := Date;
        timeSheetDetail.Quantity := Hours;
        exit(timeSheetDetail.Insert(true));
    end;

    local procedure InsertProject(No: Code[20]; Description: Text): Boolean
    var
        job: Record Job;
        res: Boolean;
    begin
        job.Init();
        job."No." := No;
        job.Description := No;
        exit(job.Insert(true));
    end;
    #endregion
}