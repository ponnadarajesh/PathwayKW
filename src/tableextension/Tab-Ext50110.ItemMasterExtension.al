tableextension 50110 "Item Master Extension" extends Item
{
    fields
    {
        // Add the new PI_Qty_On_PO field to the Item table
        field(50100; "PI_Qty_On_PO"; Decimal)
        {
            Caption = 'PI Qty. on Purch. Order';
            fieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("Document Type"=CONST(Order), Type=CONST(Item), "No."=FIELD("No.")//"Outstanding Quantity" = FILTER(> 0)
            ));
        }
        // Add the new PI_Qty_On_SO field to the Item table
        field(50101; "PI_Qty_On_SO"; Decimal)
        {
            Caption = 'PI Qty. on Sales Order';
            fieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("Document Type"=CONST(Order), Type=CONST(Item), "No."=FIELD("No.")));
        }
    }
}
