dotnet
{
    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Xml.XmlDocument"; "SystemXmlDocument") { }
        type("System.Xml.XmlNode"; "SystemXmlNode") { }
        type("System.Xml.XmlNodeList"; "SystemXmlNodeList") { }

    }

    assembly("mscorlib")
    ///Microsoft Common Object Runtime Library
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.IO.Directory"; "BCTestDirectory")
        {
        }
        //perform tasks such as checking if a directory exists, creating new directories, and listing files within a directory.

        type("System.Environment"; "BCTestEnvironment")
        {
        }
        //provides information about, and means to manipulate, the current environment and platform

        type("System.Array"; "BCTestArray")
        {
        }

        type("System.Convert"; "BCTestConvert")
        {
        }
        //methods for converting between different data types

        type("System.IO.MemoryStream"; "BCTestMemoryStream")
        {
        }
        //a stream that uses a byte array in memory as its backing store. It is useful for scenarios where you need to read from or write to a stream of data stored in memory.
    }

    assembly("Microsoft.Dynamics.Nav.Integration.Office")
    {
        Version = '19.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '31bf3856ad364e35';

        // type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHelper"; "BCTestWordHelper")
        // {
        // }

        // type("Microsoft.Dynamics.Nav.Integration.Office.Word.MergeHandler"; "BCTestMergeHandler")
        // {
        // }

        // type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHandler"; "BCTestWordHandler")
        // {
        // }
    }

    assembly("Microsoft.Office.Interop.Word")
    {
        Version = '15.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '71e9bce111e9429c';

        type("Microsoft.Office.Interop.Word.ApplicationClass"; "WordApplicationClass")
        {
        }

        type("Microsoft.Office.Interop.Word.Document"; "WordDocument")
        {
        }

        type("Microsoft.Office.Interop.Word.Range"; "Wordrange")
        {
        }
    }

    assembly("Microsoft.Dynamics.Nav.SMTP")
    {
        Version = '19.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '31bf3856ad364e35';

        type("Microsoft.Dynamics.Nav.SMTP.SmtpMessage"; "BCTestSmtpMessage")
        {
        }
    }
}
