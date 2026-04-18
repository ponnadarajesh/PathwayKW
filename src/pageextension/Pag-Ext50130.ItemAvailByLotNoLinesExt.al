// pageextension 50130 "ItemAvailLotLinesExt" extends "Item Avail. by Lot No. Lines"
// {
//     layout
//     {
//         // Add the pack fields to the end of the list repeater
//         addafter(Control1)
//         {
//             field("Description 2"; Rec."Description 2")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Pack Configuration';
//                 ToolTip = 'Pack configuration description.';
//             }
//             // field("Pack Size"; Rec.PackSize_Value)
//             // {
//             //     ApplicationArea = All;
//             //     ToolTip = 'Pack size value (units per pack).';
//             //     Caption = 'Pack Size';
//             // }
//             // field("Pack Size Code"; Rec.PackSize_Code)
//             // {
//             //     ApplicationArea = All;
//             //     ToolTip = 'Pack size code.';
//             //     Caption = 'UOM Code';
//             // }
//         }
//     }
// }
