tableextension 50100 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        // Add the new PackSize field
        field(50100; "PackSize_Code"; Code[20])
        {
            Caption = 'Pack Size Code';
            DataClassification = CustomerContent;
            //TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."), "Code" = FILTER('<>KG'));
            //Editable = false; // Usually read-only as it's fetched from Item setup
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
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
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
        // Modify the existing Unit of Measure Code field trigger
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                FetchPackConfigFromItemUOM();
                UpdateDescription2();
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                // This copies the value whenever the user selects a UOM
                Rec."PI_UOM" := Rec."Unit of Measure Code";
                // FetchPackConfigFromItemUOM();
                // UpdateDescription2();
            end;
        }
        modify(PI_UOM)
        {
            trigger OnAfterValidate()
            begin
                FetchPackConfigFromItemUOM();
                RecalcQuantityFromOrderQty();
                UpdateDescription2();
            end;
        }
        modify("Order Quantity")
        {
            trigger OnAfterValidate()
            begin
                RecalcQuantityFromOrderQty();
                UpdateDescription2();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                UpdateDescription2();
            end;
        }
    }
    procedure UpdateDescription2()
    // Updates Description 2 based on current Quantity and Pack Size
    var
        PacksPerQty: Decimal;
    begin
        if Rec.PackSize_Value <> 0 then begin
            PacksPerQty := round(rec.Quantity);// Rec.PackSize_Value, 0.01);
            Rec."Description 2" := Format(PacksPerQty, 0, 1) + ' x ' + LowerCase(Rec."Unit of Measure") + ' Packs';
        end
        else
            Rec."Description 2" := '';
    end;

    procedure FetchPackConfigFromItemUOM()
    // Fetches the pack size details from Item Unit of Measure table based on the Item No. and sets the new fields.
    var
        ItemUOM: Record "Item Unit of Measure";
        Item: Record Item;
        DefaultUOM: Code[10];
        UOM_Filter: Text[10];
    begin
        // Only execute logic if the line type is an Item and has a No.
        If rec.Type <> Rec.Type::Item then
            exit;
        Item.Get(Rec."No.");
        if item.FindFirst() then begin
            // Only execute logic if the line type is an Item and has a No.
            if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
                // If the Unit of Measure Code is a base unit of measure for the item, then we should not filter it out (e.g. KG can be a valid pack size for some items)
                //if item."Base Unit of Measure" = Rec."Unit of Measure Code" then begin
                if item."Base Unit of Measure" = Rec."PI_UOM" then begin
                    // Fetch the default unit of measure for the item and set UOM filter to next lowest UOM code.
                    ItemUOM.SetRange("Item No.", Rec."No.");
                    ItemUOM.SetFilter(Code, '<>%1', item."Base Unit of Measure");
                    ItemUOM.SetCurrentKey("Qty. per Unit of Measure");
                    ItemUOM.Ascending(true);
                end
                else begin
                    // Fetch the pack size details from Item Unit of Measure table and set the new fields.
                    ItemUOM.SetRange("Item No.", Rec."No.");
                    //ItemUOM.SetFilter(Code, Rec."Unit of Measure Code");
                    ItemUOM.SetFilter(Code, Rec."PI_UOM");
                end;
                if ItemUOM.FindFirst() then begin
                    Rec.PackSize_Code := ItemUOM.Code;
                    Rec.PackSize_Value := ItemUOM."Qty. per Unit of Measure";
                end
                else
                    Rec.PackSize_Value := 0;
                // Set Order UOM to the Item base UOM so Order Quantity is always expressed in base UOM (e.g., KG)
                Rec."Order UOM" := Item."Base Unit of Measure";
                // If line quantity already has a value, derive Order Quantity in base UOM
                if Rec.Quantity <> 0 then
                    Rec."Order Quantity" := Rec.Quantity * Rec.PackSize_Value;
            end;
        end;
    end;

    procedure RecalcQuantityFromOrderQty()
    var
        TempQty: Decimal;
    begin
        if Rec."Order Quantity" = 0 then
            exit;

        if Rec.PackSize_Value = 0 then
            FetchPackConfigFromItemUOM();

        if Rec.PackSize_Value = 0 then
            exit;

        TempQty := Rec."Order Quantity" / Rec.PackSize_Value;
        Rec.Quantity := Round(TempQty, 5);
    end;
}
