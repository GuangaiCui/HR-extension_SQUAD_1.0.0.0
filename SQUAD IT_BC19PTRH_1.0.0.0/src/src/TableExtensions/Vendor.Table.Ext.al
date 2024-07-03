tableextension 31003039 VendorRH extends Vendor
{
    fields
    {
        //HR10.0 - Anexo J
        field(31003035; "Income Type HR"; Enum IncomeTypeHR)
        {
            CaptionML = ENU = 'Income Type HR', PTG = 'Tipo Rendimento';
        }

        //HR10.0 - Anexo J
        field(31003036; "Retention Income Local"; Enum RetentionIncomeLocal)
        {
            CaptionML = ENU = 'Retention Income Local', PTG = 'Local retenção Rendimento';
        }
    }


}