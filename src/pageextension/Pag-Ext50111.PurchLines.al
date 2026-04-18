pageextension 50111 "Purch Lines" extends "Purchase Lines"
{
    layout
    {
        // Adds the field after the Unit of Measure Code on the page
        addafter("Unit of Measure Code")
        {
            // field("Pack Size"; Rec.PackSize_Value)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the quantity per unit of measure for the selected item.';
            // }
            // field("Pack Size Code"; Rec."PackSize_Code")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the code for the pack size of the selected item.';
            // }
        }
        modify("Description 2")
        {
            Caption = 'Pack Configuration';
        }
    }
}
