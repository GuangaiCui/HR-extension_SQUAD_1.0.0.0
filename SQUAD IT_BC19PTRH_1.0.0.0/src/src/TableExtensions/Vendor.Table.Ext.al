tableextension 53039 VendorRH extends Vendor
{
    fields
    {
        //HR10.0 - Anexo J
        field(53035; "Income Type HR"; Enum IncomeTypeHR)
        {
            CaptionML = ENU = 'Income Type HR', PTG = 'Tipo Rendimento';
        }

        //HR10.0 - Anexo J
        field(53036; "Retention Income Local"; Enum RetentionIncomeLocal)
        {
            CaptionML = ENU = 'Retention Income Local', PTG = 'Local retenção Rendimento';
        }
    }


}