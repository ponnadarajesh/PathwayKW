reportextension 50100 "Extra Fields on PO" extends 16034400
{
    dataset
    {
        add("Purchase Line")
        {
            column("PackSizeCode"; "PackSize_Code")
            {
            }
            column("PackSize"; "PackSize_Value")
            {
            }
            column(BaseUOM; Item."Base Unit of Measure")
            {
                Caption = 'Base Unit of Measure';
                // IncludeCaption = true;   // Uncomment if you want to use the standard caption from the Item table
            }
            column("OrderQuantity"; "Order Quantity")
            {
            }
            column(OrderUnitCost; "Order Unit Cost")
            {
            }

        }
        modify("Purchase Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                // Ensure that the related Item record is loaded to fetch the Base Unit of Measure
                if "No." <> '' then
                    if Item.Get("No.") then;
                // KGunitCost := 0;
                // If "Purchase Line"."Direct Unit Cost" <> 0 then
                //     if "Purchase Line"."Unit Cost" <> 0 then
                //         IF "Qty. per Unit of Measure" <> 0 then
                //             KGUnitCost := Round("Purchase Line"."Direct Unit Cost" / "Purchase Line"."Qty. per Unit of Measure", 0.01);
            end;
        }
    }
    var
        Item: Record Item;
        KGUnitCost: Decimal;
}
