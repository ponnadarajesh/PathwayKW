pageextension 50105 "SalesShipmentEmailExt" extends "Posted Sales Shipment"
{
    actions
    {
        addlast(processing)
        {
            action("Email Sales Shipment")
            {
                ApplicationArea = All;
                Caption = 'Email Sales Shipment';
                ToolTip = 'Open the email editor to send this shipment record.';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CompanyInfo: Record "Company Information";
                    EmailMessage: Codeunit "Email Message";
                    Email: Codeunit "Email";
                    BodyText: Text;
                    SubjectText: Text;
                    ToAddress: Text;
                    TempBlobBody: Codeunit "Temp Blob";
                    TempBlobPDF: Codeunit "Temp Blob";
                    OutStr: OutStream;
                    InStr: InStream;
                    Base64Convert: Codeunit "Base64 Convert";
                    LogoBase64: Text;
                begin
                    // 2. GET COMPANY LOGO & CONVERT TO BASE64
                    CompanyInfo.Get();
                    CompanyInfo.CalcFields(Picture);
                    if CompanyInfo.Picture.HasValue then begin
                        CompanyInfo.Picture.CreateInStream(InStr);
                        LogoBase64:=Base64Convert.ToBase64(InStr);
                    // Append the logo to the BodyText using an HTML img tag
                    //BodyText += '<br><br>Regards,<br>' + CompanyInfo.Name + '<br>';
                    //BodyText += '<img src="data:image/png;base64,' + LogoBase64 + '" width="150" />';
                    end;
                    // 1. Define Basic Details and append the logo to the BodyText using an HTML img tag
                    ToAddress:=Rec."Sell-to E-Mail";
                    SubjectText:='Shipment Notification - ' + Rec."No.";
                    BodyText:='<h1>Sales Shipment</h1> <br><br> Hello ' + Rec."Sell-to Customer Name" + ', <br><br> Please be advised your order has been shipped. See attached documents for more details. <br><br> Best Regards, <br><br>' + '<b>' + Rec."Salesperson Code" + '</b><br>' + CompanyInfo.Name + '<br>' + CompanyInfo.Address + '<br>' + CompanyInfo."Address 2" + '<br>' + CompanyInfo.City + ', ' + CompanyInfo.County + ' ' + CompanyInfo."Post Code" + ' ' + CompanyInfo."Country/Region Code" + '<br> <img src="data:image/png;base64,' + LogoBase64 + '" width="150" />';
                    // 3. Create the Email Message
                    // Parameters: (Recipient, Subject, Body, HtmlFormatted)
                    EmailMessage.Create(ToAddress, SubjectText, BodyText, true);
                    // 4. Generate the PDF from Report 208
                    TempBlobPDF.CreateOutStream(OutStr);
                    if Report.SaveAs(Report::"Sales - Shipment", '', ReportFormat::Pdf, OutStr, Rec)then begin
                        TempBlobPDF.CreateInStream(InStr);
                        // 5. Attach the InStream to the Email Message
                        EmailMessage.AddAttachment('Shipment_' + Rec."No." + '.pdf', // Filename
 'application/pdf', // Mime Type
 InStr // The Data
                        );
                    end;
                    // 3. Open Page 13 (The Email Editor)
                    // This allows the user to edit before sending
                    Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);
                end;
            }
        }
    }
}
