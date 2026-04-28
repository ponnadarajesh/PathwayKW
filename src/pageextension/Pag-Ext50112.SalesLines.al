pageextension 50112 "Sales Lines" extends "Sales Lines"
{
    layout
    {
        // Adds the field after the Unit of Measure Code on the page
        addafter(Description)
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
            field("Pack Size"; Rec.PackSize_Value)
            {
                ApplicationArea = All;
                ToolTip = 'Quantity per selected unit of measure.';
                Editable = false;
            }
        }
        modify("Description 2")
        {
            Caption = 'Pack Configuration';
        }
    }
}
