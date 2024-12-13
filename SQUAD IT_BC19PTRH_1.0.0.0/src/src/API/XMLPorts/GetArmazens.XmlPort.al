xmlport 50003 GetArmazens
{
    UseRequestPage = false;
    UseDefaultNamespace = true;

    schema
    {
        textelement(ArmazenList)
        {
            tableelement(Armazem; Location)
            {
                textelement(No)
                {
                    trigger OnBeforePassVariable()
                    begin
                        No := Armazem.Code;
                    end;
                }

                textelement(Nome)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Nome := Armazem.Name + Armazem."Name 2";
                    end;
                }
            }
        }
    }
}