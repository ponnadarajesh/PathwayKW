reportextension 50106 "Extra Fields on Cus Statement" extends 1316
{
    dataset
    {
        add("Integer")
        {
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
        }
    }
    var CompanyInfo: Record "Company Information";
    trigger OnPreReport()
    begin
        // Get the Company Information for the current company to retrieve bank and registration details
        CompanyInfo.Get();
    end;
}
