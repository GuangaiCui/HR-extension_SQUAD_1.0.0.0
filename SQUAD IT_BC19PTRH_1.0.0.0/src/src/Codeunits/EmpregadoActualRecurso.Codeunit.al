codeunit 31003035 "Empregado/Actual. Recurso"
{
    Permissions = TableData Resource = rimd;

    trigger OnRun()
    begin
    end;

    var
        Res: Record Resource;


    procedure HumanResToRes(OldEmployee: Record Empregado; Employee: Record Empregado)
    begin
        if (Employee."Resource No." <> '') and
           ((OldEmployee."Resource No." <> Employee."Resource No.") or
            (OldEmployee."Job Title" <> Employee."Job Title") or
            (OldEmployee.Name <> Employee.Name) or
            (OldEmployee."Last Name" <> Employee."Last Name") or
            (OldEmployee.Address <> Employee.Address) or
            (OldEmployee."Address 2" <> Employee."Address 2") or
            (OldEmployee."Post Code" <> Employee."Post Code") or
            (OldEmployee."No. Segurança Social" <> Employee."No. Segurança Social") or
            (OldEmployee."Employment Date" <> Employee."Employment Date"))
        then
            ResUpdate(Employee)
        else
            exit;
    end;


    procedure ResUpdate(Employee: Record Empregado)
    begin
        Res.Get(Employee."Resource No.");
        Res."Job Title" := Employee."Job Title";
        Res.Name := CopyStr(Employee.FullName, 1, 30);
        Res.Address := Employee.Address;
        Res."Address 2" := Employee."Address 2";
        Res.Validate("Post Code", Employee."Post Code");
        Res."Social Security No." := Employee."No. Segurança Social";
        Res."Employment Date" := Employee."Employment Date";
        Res.Modify(true)
    end;
}

