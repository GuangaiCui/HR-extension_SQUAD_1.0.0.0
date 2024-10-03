report 50000 "Atualiza Total Horas Semanais"
{
    // Update Nº Total Horas Semanais
    UsageCategory = Tasks;
    ApplicationArea = HumanResourcesAppArea;

    ProcessingOnly = true;
    trigger OnPostReport()
    begin
        if Employee.findset then
            repeat
                Employee."No. Horas Semanais Totais" := Employee."No. Horas Semanais";
                Employee.modify;

            until Employee.next = 0;

        Message('Terminado');
    end;


    var
        Employee: Record Empregado;
}