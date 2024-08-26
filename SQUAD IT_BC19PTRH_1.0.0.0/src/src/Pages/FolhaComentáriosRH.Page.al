#pragma implicitwith disable
page 53057 "Folha Comentários RH"
{
    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionExpression = Caption(Rec);
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Linha Coment. Recurso Humano";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Date; Rec.Date)
                {


                }
                field(Comment; Rec.Comment)
                {


                }
                field("Code"; Rec.Code)
                {


                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine;
    end;

    var
        Text000: Label 'untitled';
        Employee: Record Employee;
        EmployeeAbsence: Record "Ausência Empregado";
        EmployeeQualification: Record "Qualificação Empregado";
        EmployeeRelative: Record "Familiar Empregado";
        MiscArticleInfo: Record "Informação Artigos Div.";
        ConfidentialInfo: Record "Informação Confidencial";
        ContratoEmpregado: Record "Contrato Empregado";
        InactividadeEmpregado: Record "Inactividade Empregado";
        CatProfInternaEmp: Record "Cat. Prof. Int. Empregado";
        CatProfQPEmp: Record "Cat. Prof. QP Empregado";
        GrauEmpregado: Record "Grau Função Empregado";
        HistAusencias: Record "Histórico Ausências";
        HoraExtraEmpregado: Record "Horas Extra Empregado";
        HistHoraExtra: Record "Histórico Horas Extra";


    procedure Caption(HRCommentLine: Record "Linha Coment. Recurso Humano"): Text[110]
    begin
        case HRCommentLine."Table Name" of
            HRCommentLine."Table Name"::Aus:
                if EmployeeAbsence.Get(HRCommentLine."Table Line No.") then begin
                    Employee.Get(EmployeeAbsence."Employee No.");
                    exit(
                      Employee."No." + ' ' + Employee.FullName + ' ' +
                      EmployeeAbsence."Cause of Absence Code" + ' ' +
                      Format(EmployeeAbsence."From Date"));
                end;

            HRCommentLine."Table Name"::Emp:
                if Employee.Get(HRCommentLine."No.") then
                    exit(HRCommentLine."No." + ' ' + Employee.FullName);

            HRCommentLine."Table Name"::"Edç":
                if Employee.Get(HRCommentLine."No.") then
                    exit(
                      HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                      HRCommentLine."Alternative Address Code");

            HRCommentLine."Table Name"::Qual:
                if EmployeeQualification.Get(HRCommentLine."No.", HRCommentLine."Table Line No.") and
                   Employee.Get(HRCommentLine."No.")
                then
                    exit(
                      HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                      EmployeeQualification."Qualification Code");

            HRCommentLine."Table Name"::Fam:
                if EmployeeRelative.Get(HRCommentLine."No.", HRCommentLine."Table Line No.") and
                   Employee.Get(HRCommentLine."No.")
                then
                    exit(
                      HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                      EmployeeRelative."Relative Code");

            HRCommentLine."Table Name"::InfArt:
                if MiscArticleInfo.Get(
                   HRCommentLine."No.", HRCommentLine."Alternative Address Code", HRCommentLine."Table Line No.") and
                   Employee.Get(HRCommentLine."No.")
                then
                    exit(
                      HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                      MiscArticleInfo."Misc. Article Code");


            //Novas tabelas
            HRCommentLine."Table Name"::Cont:
                begin
                    ContratoEmpregado.SetRange(ContratoEmpregado."Cód. Empregado", HRCommentLine."No.");
                    ContratoEmpregado.SetRange(ContratoEmpregado."No. Linha", HRCommentLine."Table Line No.");
                    if (ContratoEmpregado.Find('-')) and (Employee.Get(HRCommentLine."No."))
                    then
                        exit(
                          HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                          ContratoEmpregado."Cód. Contrato");
                end;

            HRCommentLine."Table Name"::Inac:
                begin
                    InactividadeEmpregado.SetRange(InactividadeEmpregado."No. Empregado", HRCommentLine."No.");
                    InactividadeEmpregado.SetRange(InactividadeEmpregado."No. Linha", HRCommentLine."Table Line No.");
                    if (InactividadeEmpregado.Find('-')) and (Employee.Get(HRCommentLine."No."))
                    then
                        exit(
                          HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                          InactividadeEmpregado."Cód. Inactividade");
                end;

            HRCommentLine."Table Name"::CatProf:
                begin
                    CatProfInternaEmp.SetRange(CatProfInternaEmp."No. Empregado", HRCommentLine."No.");
                    CatProfInternaEmp.SetRange(CatProfInternaEmp."No. Linha", HRCommentLine."Table Line No.");
                    if (CatProfInternaEmp.Find('-')) and (Employee.Get(HRCommentLine."No."))
                    then
                        exit(
                          HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                          CatProfInternaEmp."Cód. Cat. Prof.");
                end;

            HRCommentLine."Table Name"::CatProfQP:
                begin
                    CatProfQPEmp.SetRange(CatProfQPEmp."No. Empregado", HRCommentLine."No.");
                    CatProfQPEmp.SetRange(CatProfQPEmp."No. Linha", HRCommentLine."Table Line No.");
                    if (CatProfQPEmp.Find('-')) and (Employee.Get(HRCommentLine."No."))
                    then
                        exit(
                          HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                          CatProfQPEmp."Cód. Cat. Prof. QP");
                end;

            HRCommentLine."Table Name"::Grau:
                begin
                    GrauEmpregado.SetRange(GrauEmpregado."No. Empregado", HRCommentLine."No.");
                    GrauEmpregado.SetRange(GrauEmpregado."No. Linha", HRCommentLine."Table Line No.");
                    if (GrauEmpregado.Find('-')) and (Employee.Get(HRCommentLine."No."))
                    then
                        exit(
                          HRCommentLine."No." + ' ' + Employee.FullName + ' ' +
                          GrauEmpregado."Cód. Grau Função");
                end;

            HRCommentLine."Table Name"::HAus:
                if HistAusencias.Get(HRCommentLine."Table Line No.") then begin
                    Employee.Get(HistAusencias."Employee No.");
                    exit(
                      Employee."No." + ' ' + Employee.FullName + ' ' +
                      HistAusencias."Cause of Absence Code" + ' ' +
                      Format(HistAusencias."From Date"));
                end;


            HRCommentLine."Table Name"::HorEx:
                if HoraExtraEmpregado.Get(HRCommentLine."Table Line No.") then begin
                    Employee.Get(HoraExtraEmpregado."No. Empregado");
                    exit(
                      Employee."No." + ' ' + Employee.FullName + ' ' +
                      HoraExtraEmpregado."Cód. Hora Extra" + ' ' +
                      Format(HoraExtraEmpregado.Data));
                end;


            HRCommentLine."Table Name"::HHorEx:
                if HistHoraExtra.Get(HRCommentLine."Table Line No.") then begin
                    Employee.Get(HistHoraExtra."No. Empregado");
                    exit(
                      Employee."No." + ' ' + Employee.FullName + ' ' +
                      HistHoraExtra."Cód. Hora Extra" + ' ' +
                      Format(HistHoraExtra.Data));
                end;

        end;
        exit(Text000);
    end;
}

#pragma implicitwith restore

