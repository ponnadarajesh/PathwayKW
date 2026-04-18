reportextension 50102 "Extra Fields on PSS" extends 208
{
    dataset
    {
        add("Sales Shipment Line")
        {
            column("PackSizeCode"; "PackSize_Code")
            {
            }
            column("PackSize"; "PackSize_Value")
            {
            }
            column("Description2"; "Description 2")
            {
            }
        }
        add("Sales Shipment Header")
        {
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Customer_Name_2; "Sell-to Customer Name 2")
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(Sell_to_Address_2; "Sell-to Address 2")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(Sell_to_County; "Sell-to County")
            {
            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {
            }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyRegisterationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyABNPartNo; CompanyInfo."ABN Division Part No.")
            {
            }
            column(CompanyABN; CompanyInfo.ABN)
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        // Get the Company Information for the current company to retrieve bank and registration details
        CompanyInfo.Get();
    end;
}
