report 50101 "PI Inventory Analysis Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Report/InventoryAnalysis.rdlc';
    Caption = 'PI Inventory Analysis Report';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Date Filter";

            column(ItemNo; "No.")
            {
            }
            column(ItemDescription; Item.Description)
            {
            }
            column(BaseInventory; BaseInventory)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            dataitem(InventoryBuffer; Integer)
            {
                DataItemLinkReference = Item;

                column(DocNo; TempBuffer."Document No.")
                {
                }
                column(DocType; TempBuffer."Document Type")
                {
                }
                column(Description; TempBuffer.Description)
                {
                }
                column(OrderDate; TempBuffer."Order Date")
                {
                }
                column(RequestedDate; TempBuffer."Requested Date")
                {
                }
                column(PromisedDate; TempBuffer."Promised Date")
                {
                }
                column(QtyOnPO; TempBuffer."Qty On PO")
                {
                }
                column(QtyOnSO; TempBuffer."Qty On SO")
                {
                }
                column(Notes; TempBuffer.Notes)
                {
                }
                trigger OnPreDataItem()
                begin
                    TempBuffer.Reset();
                    SetRange(Number, 1, TempBuffer.Count());
                end;
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then TempBuffer.FindSet()
                    else
                        TempBuffer.Next();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // 1. Capture the original filter the user entered
                DateFilter:=Item.GetFilter("Date Filter");
                // 2. Determine the Start Date
                if DateFilter <> '' then begin
                    StartDate:=Item.GetRangeMin("Date Filter");
                    EndDate:=Item.GetRangeMax("Date Filter");
                end
                else
                begin
                    StartDate:=WorkDate(); // Default if no filter is provided
                    EndDate:=WorkDate(); // To include the end date in calculations
                end;
                FetchMovementLines(Item."No.");
                // 3. Calculate "Opening Balance" (Inventory up to the day before StartDate)
                Item.SetRange("Date Filter", 0D, StartDate - 1);
                Item.CalcFields(Inventory);
                if TempBuffer.Count() > 0 then BaseInventory:=Item.Inventory
                else
                    BaseInventory:=0;
                // Clear filter to fetch future movements
                Item.SetFilter("Date Filter", DateFilter);
            end;
        }
    }
    var TempBuffer: Record "Inventory Report Buffer" temporary;
    BaseInventory: Decimal;
    DateFilter: Text;
    StartDate: Date;
    EndDate: Date;
    local procedure FetchMovementLines(ItemNo: Code[20])
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        TempBuffer.DeleteAll();
        // Fetch POs
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        PurchLine.SetRange("No.", ItemNo);
        PurchLine.SetFilter("Outstanding Quantity", '>0');
        if PurchLine.FindSet()then begin
            repeat //PurchHeader.get(PurchHeader."Document Type"::Order, PurchLine."Document No.");
                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                PurchHeader.SetRange("No.", PurchLine."Document No.");
                PurchHeader.SetRange("Order Date", StartDate, EndDate);
                if PurchHeader.FindFirst()then InsertToBuffer(PurchLine."Document No.", 'PO', PurchHeader."Buy-from Vendor Name", PurchHeader."Order Date", PurchLine."Expected Receipt Date", PurchLine."Promised Receipt Date", PurchLine."Outstanding Quantity", 0, PurchLine."KBIZ Custom Field-TEXT-01");
            until PurchLine.Next() = 0;
        end;
        // Fetch SOs
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", ItemNo);
        SalesLine.SetFilter("Outstanding Quantity", '>0');
        if SalesLine.FindSet()then begin
            repeat //SalesHeader.get(SalesHeader."Document Type"::Order, SalesLine."Document No.");
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("No.", SalesLine."Document No.");
                SalesHeader.SetRange("Order Date", StartDate, EndDate);
                if SalesHeader.FindFirst()then InsertToBuffer(SalesLine."Document No.", 'SO', SalesHeader."Sell-to Customer Name", SalesHeader."Order Date", SalesLine."Requested Delivery Date", SalesLine."Promised Delivery Date", 0, SalesLine."Outstanding Quantity", SalesLine."KBIZ Custom Field-TEXT-01");
            until SalesLine.Next() = 0;
        end;
        TempBuffer.SetCurrentKey("Promised Date"); // Sorting by Promised Date
        TempBuffer.Ascending(true);
    end;
    local procedure InsertToBuffer(Doc: Code[20]; Type: Text; Desc: Text; OrdDt: Date; ReqDt: Date; PromDt: Date; QPO: Decimal; QSO: Decimal; pNotes: Text)
    begin
        TempBuffer.Init();
        TempBuffer."Line No."+=1; // Increment by 1 for temporary records
        TempBuffer."Document No.":=Doc;
        TempBuffer."Document Type":=CopyStr(Type, 1, 15);
        TempBuffer.Description:=CopyStr(Desc, 1, 100);
        TempBuffer."Order Date":=OrdDt;
        TempBuffer."Requested Date":=ReqDt;
        TempBuffer."Promised Date":=PromDt;
        TempBuffer."Qty On PO":=QPO;
        TempBuffer."Qty On SO":=QSO;
        TempBuffer.Notes:=CopyStr(pNotes, 1, 250);
        TempBuffer.Insert();
    end;
}
