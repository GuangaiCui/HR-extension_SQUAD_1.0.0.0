// report 59886 "Declaration RH"
// {
//TODO:To delete, already replaced by DeclaraçõesRHBC19
//CGA SQD to delete
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultRenderingLayout = LayoutName;

//     dataset
//     {
//         dataitem(DataItemName; Employee)
//         {
//             column(EmployeeName; Name)
//             {
//             }
//             column(EmployeeIDType; "Documento Identificação")
//             {
//             }
//             column(EmployeeIDNo; "No. Doc. Identificação")
//             {
//             }
//             column(EmployeeIDIssueLoc; "Local Emissão Doc. Ident.")
//             {
//             }
//             column(EmployeeIDExpireDate; "Data Validade Doc. Ident.")
//             { }
//             column(EmployeeDate; "Employment Date")
//             { }
//             column(EmployeeContractCode; "Emplymt. Contract Code")
//             { }
//             dataitem("Company Information"; "Company Information")
//             {

//             }

//             rCompanyInformation.Name
//             rCompanyInformation."Name 2"
//             rCompanyInformation.Address
//             rCompanyInformation."Address 2"
//             rCompanyInformation."Post Code"
//             rCompanyInformation.City
//             rCompanyInformation."Phone No."
//             rCompanyInformation."Fax No."
//             rCompanyInformation."VAT Registration No."
//                             if Empregado.Vitalício = true then
//                     EscreveWord('«data validade»', 'vitalício')
//                 else
//                     EscreveWord('«data validade»', Format(Empregado."Data Validade Doc. Ident."));
// Contratos."Tipo Contrato"
//         }
//         }
//                                 Contratos.Reset;
//                 if Contratos.Get(Empregado."Emplymt. Contract Code") then
//                     EscreveWord('«tipo contrato»', Format(Contratos."Tipo Contrato"));
//                 TabRubricaSalEmpregado.Reset;
//                 TabRubricaSalEmpregado.SetRange(TabRubricaSalEmpregado."No. Empregado", Empregado."No.");
//                 TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Início", '<=%1', Today);
//                 TabRubricaSalEmpregado.SetFilter(TabRubricaSalEmpregado."Data Fim", '>%1|=%2', Today, 0D);
//                 if TabRubricaSalEmpregado.FindSet then begin
//                     repeat
//                         if (TabRubrica.Get(TabRubricaSalEmpregado."Cód. Rúbrica Salarial")) and
//                           (TabRubrica.Genero = TabRubrica.Genero::"Vencimento Base") then begin
//                             VencimentoBase := VencimentoBase + TabRubricaSalEmpregado."Valor Total";
//                         end;
//                     until TabRubricaSalEmpregado.Next = 0;
//                 end;

//                 EscreveWord('«vencimento base»', Format(VencimentoBase));
//                 EscreveWord('«localidade»', rCompanyInformation.City);
//                 EscreveWord('«data»', Format(Today, 0, '<day> de <month text> de <year4>'));
//                 EscreveWord('«nome da pessoa assina»', NomePessoaAssina);
//                 EscreveWord('«cargo»', cargo);


//     requestpage
//     {
//         AboutTitle = 'Teaching tip title';
//         AboutText = 'Teaching tip content';
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(Name; SourceExpression)
//                     {
//                         ApplicationArea = All;

//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(LayoutName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     rendering
//     {
//         layout(LayoutName)
//         {
//             Type = Excel;
//             LayoutFile = 'mySpreadsheet.xlsx';
//         }
//     }

//     var
//         myInt: Integer;

// }