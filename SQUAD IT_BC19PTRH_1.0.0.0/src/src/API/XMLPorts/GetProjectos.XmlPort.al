xmlport 50001 GetProjectos
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ProjectoList)
        {
            tableelement(Projecto; "Dimension Value")
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable();
                    begin
                        No := Projecto.Code;
                    end;
                }

                textelement(Nome)
                {
                    trigger OnBeforePassVariable();
                    begin
                        Nome := Projecto.Name;
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    Projecto.SetRange("Dimension Code", 'PROJ');
                end;
            }
        }
    }
}