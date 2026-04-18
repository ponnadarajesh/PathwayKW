pageextension 50109 "Item Master Ext" extends "Item Card"
{
    layout
    {
        addafter("Qty. on Purch. Order")
        {
            field(PI_Qty_On_PO; Rec.PI_Qty_On_PO)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity per unit of measure for the selected item.';
                DecimalPlaces = 0: 5;
                Editable = false;
            }
        }
        addafter("Qty. on Sales Order")
        {
            field(PI_Qty_On_SO; Rec.PI_Qty_On_SO)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity per unit of measure for the selected item.';
                DecimalPlaces = 0: 5;
                Editable = false;
            }
        }
    }
}
