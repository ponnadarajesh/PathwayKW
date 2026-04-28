pageextension 50111 "Purch Lines" extends "Purchase Lines"
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
            field("Order Price"; Rec."Order Unit Cost")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Calculated price for the order quantity.';
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
