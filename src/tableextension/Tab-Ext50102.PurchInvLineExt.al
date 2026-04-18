tableextension 50102 "Purch. Inv. Line Ext" extends "Purch. Inv. Line"
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
            DecimalPlaces = 0: 5;
            Editable = false; // Usually read-only as it's fetched from Item setup
        }
        field(50102; "PI_UOM"; Code[10])
        {
            Caption = 'UOM';
            DataClassification = CustomerContent;
            //TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
            Editable = false;
        }
    }
}
