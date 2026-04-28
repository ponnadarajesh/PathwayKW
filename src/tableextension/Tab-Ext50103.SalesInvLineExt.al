tableextension 50103 "Sales Inv. Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        // Add the new PackSize field
        field(50100; "PackSize_Code"; Code[20])
        {
            Caption = 'Pack Size Code';
            DataClassification = CustomerContent;
            Editable = false; // Usually read-only as it's fetched from Item setup
        }
        field(50101; "PackSize_Value"; Decimal)
        {
            Caption = 'Pack Size';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false; // Usually read-only as it's fetched from Item setup
        }
        field(50102; "PI_UOM"; Code[10])
        {
            Caption = 'UOM';
            DataClassification = CustomerContent;
            //TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
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
        field(50105; "Order Unit Price"; Decimal)
        {
            Caption = 'Order Unit Price';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
    }

}
