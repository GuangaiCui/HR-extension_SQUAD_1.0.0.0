tableextension 53039 VendorRH extends Vendor
{
    fields
    {
        //HR10.0 - Anexo J
        field(53035; "Income Type HR"; Enum IncomeTypeHR)
        {
            Caption = 'Tipo Rendimento';
        }

        //HR10.0 - Anexo J
        field(53036; "Retention Income Local"; Enum RetentionIncomeLocal)
        {
            Caption = 'Local retenção Rendimento';
        }
    }


}