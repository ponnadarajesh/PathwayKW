reportextension 50104 "Extra Fields on PSI" extends 1306
{
    dataset
    {
        add("Line")
        {
            column("Description2"; "Description 2")
            {
            }
            column(LotNoTxt; GetLotNumbers("Line"))
            {
            }
            column("OrderQuantity"; "Order Quantity")
            {
            }
            column("OrderUOM"; "Order UOM")
            {
            }
            column("OrderUnitPrice"; "Order Unit Price")
            {
            }
        }
        add(Header)
        {
            column(CustomerABN; CustABN)
            {
            }
            column(CustomerPO; "External Document No.")
            {
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                // Fetch the ABN for the customer on the invoice
                if "Sell-to Customer No." <> '' then begin
                    CustABN := '';
                    if CustTable.Get("Sell-to Customer No.") then
                        CustABN := CustTable.ABN;
                end;
            end;
        }
    }
    procedure GetLotNumbers(SalesInvoiceLine: Record "Sales Invoice Line"): Text
    var
        TrackSpec: Record "Item Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesShipHeader: Record "Sales Shipment Header";
        LotNumbers: Text;
    begin
        // Get the related Sales Invoice Header for Sales Invoice Line Doc No.
        SalesInvoiceHeader.Get(SalesInvoiceLine."Document No.");
        if SalesInvoiceHeader."No." = '' then exit('');
        // Get the related Sales Shipment Header for Sales Invoice Header Order No.
        SalesShipHeader.SetRange("Order No.", SalesInvoiceHeader."Order No.");
        if SalesShipHeader.FindFirst() then begin
            repeat // Filter Reservation Entries for the specific Sales Line
                TrackSpec.SetRange("Item No.", SalesInvoiceLine."No.");
                TrackSpec.SetRange("Entry Type", TrackSpec."Entry Type"::"Sale");
                TrackSpec.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
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
    end;

    var
        CustABN: Code[20];
        CustTable: Record customer;
}
