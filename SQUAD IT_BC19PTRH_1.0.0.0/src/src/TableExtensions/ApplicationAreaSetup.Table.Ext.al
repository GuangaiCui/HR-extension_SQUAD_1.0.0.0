tableextension 53035 "ApplicationAreaSetupRH" extends "Application Area Setup"
{
    fields
    {
        // Spaces in field name are omitted in the ApplicationArea attribute
        // e.g. ApplicationArea = ExampleAppArea;
        field(50000; HumanResource; Boolean)

        {
            Caption = 'Human Resource Extension Area';
        }
    }
}