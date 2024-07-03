dotnet
{
    assembly("Microsoft.VisualBasic")
    {
        Version = '10.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("Microsoft.VisualBasic.Interaction"; MicrosoftVisualBasicInteraction) { }

    }

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
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.IO.Directory"; "BCTestDirectory")
        {
        }

        type("System.Environment"; "BCTestEnvironment")
        {
        }

        type("System.Array"; "BCTestArray")
        {
        }

        type("System.Convert"; "BCTestConvert")
        {
        }

        type("System.IO.MemoryStream"; "BCTestMemoryStream")
        {
        }

    }

    assembly("Microsoft.Dynamics.Nav.Integration.Office")
    {
        Version = '19.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '31bf3856ad364e35';

        type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHelper"; "BCTestWordHelper")
        {
        }

        type("Microsoft.Dynamics.Nav.Integration.Office.Word.MergeHandler"; "BCTestMergeHandler")
        {
        }

        type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHandler"; "BCTestWordHandler")
        {
        }
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

        type("Microsoft.Office.Interop.Word.InlineShape"; "BCTestInlineShape")
        {
        }

        type("Microsoft.Office.Interop.Word.OLEFormat"; "BCTestOLEFormat")
        {
        }

        type("Microsoft.Office.Interop.Word.LinkFormat"; "BCTestLinkFormat")
        {
        }
    }
    /*
        assembly("Microsoft.Office.Interop.Excel")
        {
            Version = '15.0.0.0';
            Culture = 'neutral';
            PublicKeyToken = '71e9bce111e9429c';

            type("Microsoft.Office.Interop.Excel.ApplicationClass"; "ExcelApplicationClass")
            {
            }

            type("Microsoft.Office.Interop.Excel.Workbook"; "ExcelWorkbook")
            {
            }

            type("Microsoft.Office.Interop.Excel.Range"; "ExcelRange")
            {
            }

            type("Microsoft.Office.Interop.Excel.Worksheet"; "ExcelWorksheet")
            {
            }

            type("Microsoft.Office.Interop.Excel.Sheets"; "ExcelSheets")
            {
            }
        }
    */
    assembly("")
    {
        type(""; "BCTest")
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


    assembly("Microsoft.Dynamics.Nav.Client.BusinessChart")
    {
        type("Microsoft.Dynamics.Nav.Client.BusinessChart.BusinessChartAddIn"; "Microsoft.Dynamics.Nav.Client.BusinessChart")
        {
            IsControlAddIn = true;
        }
    }

    //   assembly("Microsoft.Dynamics.Nav.Client.DynamicsOnlineConnect")
    //    {
    //        type("Microsoft.Dynamics.Nav.Client.DynamicsOnlineConnect.IDynamicsOnlineConnectControlDefinition"; "Microsoft.Dynamics.Nav.Client.DynamicsOnlineConnect")
    //        {
    //            IsControlAddIn = true;
    //        }
    //    }

    assembly("Microsoft.Dynamics.Nav.Client.FlowIntegration")
    {
        type("Microsoft.Dynamics.Nav.Client.FlowIntegration.IFlowIntegration"; "Microsoft.Dynamics.Nav.Client.FlowIntegration")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.OAuthIntegration")
    {
        type("Microsoft.Dynamics.Nav.Client.OAuthIntegration.OAuthIntegration"; "Microsoft.Dynamics.Nav.Client.OAuthIntegration")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.PageReady")
    {
        type("Microsoft.Dynamics.Nav.Client.PageReady.IPageReady"; "Microsoft.Dynamics.Nav.Client.PageReady")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.PingPong")
    {
        type("Microsoft.Dynamics.Nav.Client.PingPong.PingPongAddIn"; "Microsoft.Dynamics.Nav.Client.PingPong")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.PowerBIManagement")
    {
        type("Microsoft.Dynamics.Nav.Client.PowerBIManagement.PowerBIManagement"; "Microsoft.Dynamics.Nav.Client.PowerBIManagement")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.RoleCenterSelector")
    {
        type("Microsoft.Dynamics.Nav.Client.RoleCenterSelector.IRoleCenterSelector"; "Microsoft.Dynamics.Nav.Client.RoleCenterSelector")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.SocialListening")
    {
        type("Microsoft.Dynamics.Nav.Client.SocialListening.ISocialListening"; "Microsoft.Dynamics.Nav.Client.SocialListening")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.TimelineVisualization")
    {
        type("Microsoft.Dynamics.Nav.Client.TimelineVisualization.InteractiveTimelineVisualizationAddIn"; "Microsoft.Dynamics.Nav.Client.TimelineVisualization")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.VideoPlayer")
    {
        type("Microsoft.Dynamics.Nav.Client.VideoPlayer.IVideoPlayer"; "Microsoft.Dynamics.Nav.Client.VideoPlayer")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.WebPageViewer")
    {
        type("Microsoft.Dynamics.Nav.Client.WebPageViewer.IWebPageViewer"; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
        {
            IsControlAddIn = true;
        }
    }

    assembly("Microsoft.Dynamics.Nav.Client.WelcomeWizard")
    {
        type("Microsoft.Dynamics.Nav.Client.WelcomeWizard.IWelcomeWizard"; "Microsoft.Dynamics.Nav.Client.WelcomeWizard")
        {
            IsControlAddIn = true;
        }
    }

}
