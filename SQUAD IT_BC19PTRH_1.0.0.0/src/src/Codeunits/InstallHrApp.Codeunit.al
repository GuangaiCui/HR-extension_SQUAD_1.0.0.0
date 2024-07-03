codeunit 53043 "Install HR Extension"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        EnableApplicationArea: Codeunit "Enable HR Extension";
    begin
        if (EnableApplicationArea.IsHrApplicationAreaEnabled()) then
            exit;

        EnableApplicationArea.EnableHrExtension();

        // Add your code here
    end;
}