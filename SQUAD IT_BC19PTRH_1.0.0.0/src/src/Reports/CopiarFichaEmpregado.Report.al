report 53105 "Copiar Ficha Empregado"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(Empregado; Empregado)
        {
            dataitem("Endereço Alternativo"; "Endereço Alternativo")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", Code);

                trigger OnAfterGetRecord()
                begin
                    NovoEnderecoAlt.Init;
                    NovoEnderecoAlt.TransferFields("Endereço Alternativo");
                    NovoEnderecoAlt."Employee No." := NovoEmpregado."No.";
                    NovoEnderecoAlt.Insert;
                end;
            }
            dataitem("Contrato Empregado"; "Contrato Empregado")
            {
                DataItemLink = "Cód. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("Cód. Empregado", "Cód. Contrato", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    NovoContratoEmp.Init;
                    NovoContratoEmp.TransferFields("Contrato Empregado");
                    NovoContratoEmp."Cód. Empregado" := NovoEmpregado."No.";
                    NovoContratoEmp.Insert;
                end;
            }
            dataitem("Cat. Prof. Int. Empregado"; "Cat. Prof. Int. Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Cód. Cat. Prof.", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    NovoCatProfIntEmp.Init;
                    NovoCatProfIntEmp.TransferFields("Cat. Prof. Int. Empregado");
                    NovoCatProfIntEmp."No. Empregado" := NovoEmpregado."No.";
                    NovoCatProfIntEmp.Insert;
                end;
            }
            dataitem("Cat. Prof. QP Empregado"; "Cat. Prof. QP Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Cód. Cat. Prof. QP", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    NovoCatProfQPEmp.Init;
                    NovoCatProfQPEmp.TransferFields("Cat. Prof. QP Empregado");
                    NovoCatProfQPEmp."No. Empregado" := NovoEmpregado."No.";
                    NovoCatProfQPEmp.Insert;
                end;
            }
            dataitem("Qualificação Empregado"; "Qualificação Empregado")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", Type, "Line No.");

                trigger OnAfterGetRecord()
                begin
                    NovoQualEmp.Init;
                    NovoQualEmp.TransferFields("Qualificação Empregado");
                    NovoQualEmp."Employee No." := NovoEmpregado."No.";
                    NovoQualEmp.Insert;
                end;
            }
            dataitem("Horário Empregado"; "Horário Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Cód. Horário", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    NovoHorEmp.Init;
                    NovoHorEmp.TransferFields("Horário Empregado");
                    NovoHorEmp."No. Empregado" := NovoEmpregado."No.";
                    NovoHorEmp.Insert;
                end;
            }
            dataitem("Rubrica Salarial Empregado"; "Rubrica Salarial Empregado")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "No. Linha");

                trigger OnAfterGetRecord()
                begin
                    NovoRubSalEmp.Init;
                    NovoRubSalEmp.TransferFields("Rubrica Salarial Empregado");
                    NovoRubSalEmp."No. Empregado" := NovoEmpregado."No.";
                    NovoRubSalEmp.Insert;
                end;
            }
            dataitem("Distribuição Custos"; "Distribuição Custos")
            {
                DataItemLink = "No. Empregado" = FIELD("No.");
                DataItemTableView = SORTING("No. Empregado", "Data Inicio", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code");

                trigger OnAfterGetRecord()
                begin
                    NovoDistCustos.Init;
                    NovoDistCustos.TransferFields("Distribuição Custos");
                    NovoDistCustos."No. Empregado" := NovoEmpregado."No.";
                    NovoDistCustos.Insert;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if HumanResSetup.Get then;
                NovoEmpregado.Init;
                NovoEmpregado.TransferFields(Empregado);
                NovoEmpregado."No." := NoSeriesMgt.GetNextNo(HumanResSetup."Employee Nos.", 0D, true);
                NovoEmpregado.Insert(true);
                NovoEmpregado.Validate(NovoEmpregado.Name, Empregado.Name);
                NovoEmpregado.Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message(Text0001, NovoEmpregado."No.");
    end;

    var
        NovoEmpregado: Record Empregado;
        HumanResSetup: Record "Config. Recursos Humanos";
        NovoEnderecoAlt: Record "Endereço Alternativo";
        NovoContratoEmp: Record "Contrato Empregado";
        NovoCatProfIntEmp: Record "Cat. Prof. Int. Empregado";
        NovoCatProfQPEmp: Record "Cat. Prof. QP Empregado";
        NovoQualEmp: Record "Qualificação Empregado";
        NovoHorEmp: Record "Horário Empregado";
        NovoRubSalEmp: Record "Rubrica Salarial Empregado";
        NovoDistCustos: Record "Distribuição Custos";
        NoSeriesMgt: Codeunit "No. Series";
        Text0001: Label 'Foi criado o empregado %1.';
}

