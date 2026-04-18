tableextension 50112 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50113; "PackSize_Code"; Code[20])
        {
            Caption = 'Pack Size Code';
            DataClassification = CustomerContent;
        }
        field(50114; "PackSize_Value"; Decimal)
        {
            Caption = 'Pack Size';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(50115; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
    }
}
