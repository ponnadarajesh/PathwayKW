pageextension 50104 "Extra Fields on PSS Line" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        // Adds the field after the Unit of Measure Code on the page
        addafter("Unit of Measure Code")
        {
            field("UOM"; Rec.PI_UOM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the unit of measure for the quantity of the selected item.';
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
