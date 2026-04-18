reportextension 50105 "Extra Fields on ProForma Inv" extends 1302
{
    dataset
    {
        add("Header")
        {
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Name2; "Ship-to Name 2")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address2; "Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_County; "Ship-to County")
            {
            }
            column(Ship_to_PostCode; "Ship-to Post Code")
            {
            }
            column(Ship_to_CountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(Ship_to_Phone_No_; "Ship-to Phone No.")
            {
            }
            column(Ship_to_Code; "Ship-to Code")
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
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Bill_to_Name2; "Bill-to Name 2")
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Bill_to_Address2; "Bill-to Address 2")
            {
            }
            column(Bill_to_City; "Bill-to City")
            {
            }
            column(Bill_to_County; "Bill-to County")
            {
            }
            column(Bill_to_PostCode; "Bill-to Post Code")
            {
            }
            column(Bill_to_CountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }
        //column(LotNoTxt; GetLotNumbers("Line")) { }
        }
        add("Line")
        {
            column(No_; "No.")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
            {
            }
        //column(LotNoTxt; GetLotNumbers("Line")) { }
        }
    }
    var CompanyInfo: Record "Company Information";
    // CompanyRegisterationNo: text;
    // CompanyABNPartNo: Text;
    // CompanyABN: Text;
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    // CompanyRegisterationNo := CompanyInfo."Registration No.";
    // CompanyABNPartNo := CompanyInfo."ABN Division Part No.";
    // CompanyABN := CompanyInfo.ABN;
    end;
/*     procedure GetLotNumbers(ProFormaInvoiceLine: Record "Pro Forma Invoice Line"): Text
        var
            TrackSpec: Record "Item Ledger Entry";
            ProFormaInvoiceHeader: Record "Pro Forma Invoice Header";
            SalesShipHeader: Record "Sales Shipment Header";
            LotNumbers: Text;
        begin

            // Get the related Pro Forma Invoice Header for Pro Forma Invoice Line Doc No.
            ProFormaInvoiceHeader.Get(ProFormaInvoiceLine."Document No.");
            if ProFormaInvoiceHeader."No." = '' then
                exit('');
            // Get the related Sales Shipment Header for Pro Forma Invoice Header Order No.
            SalesShipHeader.SetRange("Order No.", ProFormaInvoiceHeader."Order No.");
            if SalesShipHeader.FindFirst() then begin
                repeat

                    // Filter Reservation Entries for the specific Pro Forma Invoice Line
                    TrackSpec.SetRange("Item No.", ProFormaInvoiceLine."No.");
                    TrackSpec.SetRange("Entry Type", TrackSpec."Entry Type"::"Sale");
                    TrackSpec.SetRange("Document Line No.", ProFormaInvoiceLine."Line No.");
                    TrackSpec.SetRange("Document No.", SalesShipHeader."No.");
                    TrackSpec.SetRange("Item Tracking", TrackSpec."Item Tracking"::"Lot No.");

                    if TrackSpec.FindSet() then begin
                        repeat
                            if TrackSpec."Lot No." <> '' then begin
                                if LotNumbers = '' then
                                    LotNumbers := TrackSpec."Lot No."
                                else
                                    LotNumbers += ', ' + TrackSpec."Lot No.";
                            end;
                        until TrackSpec.Next() = 0;
                    end;
                until SalesShipHeader.Next() = 0;
            end;

            exit(LotNumbers);
        end; */
}
