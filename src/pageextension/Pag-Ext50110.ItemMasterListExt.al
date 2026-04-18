pageextension 50110 "Item Master List Ext" extends "Item List"
{
    layout
    {
        addafter("Type")
        {
            field(PI_Qty_On_PO; Rec.PI_Qty_On_PO)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity Qt. on Purchase Orders for the selected item.';
                DecimalPlaces = 0: 5;
                Editable = false;
            }
            field("PI_Qty_On_SO"; Rec.PI_Qty_On_SO)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity Qt. on Sales Orders for the selected item.';
                DecimalPlaces = 0: 5;
                Editable = false;
            }
        }
    }
}
