pageextension 50103 "Posted Sales Inv. Subform Ext" extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Adds the field after the Unit of Measure Code on the page
        addafter(description)
        {
            field("Order Quantity"; Rec."Order Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Order quantity expressed in the item base unit of measure (for example, KG).';
            }
            field("Order UOM"; Rec."Order UOM")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Base unit of measure used for the Order Quantity.';
            }
            field("Order Unit Price"; Rec."Order Unit Price")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Calculated price per base unit of measure for the order quantity.';
            }
            field("UOM"; Rec.PI_UOM)
            {
                ApplicationArea = All;
                Caption = 'UOM';
                ToolTip = 'Specifies the Unit of Measure for the selected item.';
            }
            field("Pack Size"; Rec.PackSize_Value)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity per unit of measure for the selected item.';
            }
            field("Pack Size Code"; Rec."PackSize_Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the pack size of the selected item.';
            }
        }
        modify("Description 2")
        {
            Caption = 'Pack Configuration';
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
    }
}
