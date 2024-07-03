tableextension 53035 "ApplicationAreaSetupRH" extends "Application Area Setup"
{
    fields
    {
        // Spaces in field name are omitted in the ApplicationArea attribute
        // e.g. ApplicationArea = ExampleAppArea;
        field(50000; "Human Resources App Area"; Boolean)

        {
            CaptionML = ENU = 'Human Resources App Area', PTG = 'App Área Recursos Humanos';
        }
    }
}