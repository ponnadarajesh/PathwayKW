tableextension 50106 "Purch. Rcpt. Line Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50100; "PackSize_Code"; Code[20])
        {
            Caption = 'Pack Size Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50101; "PackSize_Value"; Decimal)
        {
            Caption = 'Pack Size';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50102; "PI_UOM"; Code[10])
        {
            Caption = 'UOM';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50103; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity (Base UOM)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(50104; "Order UOM"; Code[10])
        {
            Caption = 'Order UOM';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50105; "Order Unit Cost"; Decimal)
        {
            Caption = 'Order Unit Cost';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }

        // modify("No.")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         FetchPackConfigFromItemUOM();
        //         UpdateDescription2();
        //     end;
        // }

        // modify("Unit of Measure Code")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         Rec."PI_UOM" := Rec."Unit of Measure Code";
        //         FetchPackConfigFromItemUOM();
        //         RecalcQuantityFromOrderQty();
        //         UpdateDescription2();
        //     end;
        // }

        // modify(PI_UOM)
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         FetchPackConfigFromItemUOM();
        //         RecalcQuantityFromOrderQty();
        //         UpdateDescription2();
        //     end;
        // }

        // modify("Order Quantity")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         RecalcQuantityFromOrderQty();
        //         UpdateDescription2();
        //         CalculateOrderPrice();
        //     end;
        // }

        // modify("Direct Unit Cost")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         CalculateOrderPrice();
        //     end;
        // }

        // modify(Quantity)
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         UpdateDescription2();
        //     end;
        // }
    }

    // procedure UpdateDescription2()
    // var
    //     PacksPerQty: Decimal;
    // begin
    //     if Rec.PackSize_Value <> 0 then begin
    //         PacksPerQty := Round(Rec.Quantity);
    //         Rec."Description 2" := Format(PacksPerQty, 0, 1) + ' x ' + LowerCase(Rec."Unit of Measure") + ' Packs';
    //     end else
    //         Rec."Description 2" := '';
    // end;

    // procedure FetchPackConfigFromItemUOM()
    // var
    //     ItemUOM: Record "Item Unit of Measure";
    //     Item: Record Item;
    // begin
    //     If Rec.Type <> Rec.Type::Item then
    //         exit;
    //     Item.Get(Rec."No.");
    //     if Item.FindFirst() then begin
    //         if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
    //             if Item."Base Unit of Measure" = Rec."PI_UOM" then begin
    //                 ItemUOM.SetRange("Item No.", Rec."No.");
    //                 ItemUOM.SetFilter(Code, '<>%1', Item."Base Unit of Measure");
    //                 ItemUOM.SetCurrentKey("Qty. per Unit of Measure");
    //                 ItemUOM.Ascending(true);
    //             end else begin
    //                 ItemUOM.SetRange("Item No.", Rec."No.");
    //                 ItemUOM.SetFilter(Code, Rec."PI_UOM");
    //             end;
    //             if ItemUOM.FindFirst() then begin
    //                 Rec.PackSize_Code := ItemUOM.Code;
    //                 Rec.PackSize_Value := ItemUOM."Qty. per Unit of Measure";
    //             end else
    //                 Rec.PackSize_Value := 0;
    //             Rec."Order UOM" := Item."Base Unit of Measure";
    //         end;
    //     end;
    // end;

    // procedure RecalcQuantityFromOrderQty()
    // var
    //     TempQty: Decimal;
    // begin
    //     if Rec."Order Quantity" = 0 then
    //         exit;

    //     if Rec.PackSize_Value = 0 then
    //         FetchPackConfigFromItemUOM();

    //     if Rec.PackSize_Value = 0 then
    //         exit;

    //     TempQty := Round(Rec."Order Quantity" / Rec."Qty. per Unit of Measure", 0.00001);
    //     Rec.Validate(Quantity, TempQty);
    //     Rec.Validate("Direct Unit Cost");
    // end;

    // procedure CalculateOrderPrice()
    // begin
    //     if Rec."Qty. per Unit of Measure" <> 0 then
    //         Rec."Order Unit Cost" := Round((Rec."Direct Unit Cost" / Rec."Qty. per Unit of Measure"), 0.01)
    //     else
    //         Rec."Order Unit Cost" := 0;
    // end;
}
