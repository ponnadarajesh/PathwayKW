tableextension 50114 "Availability Info Buffer Ext" extends "Availability Info. Buffer"
{
    fields
    {
        field(50119; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(50120; "PackSize_Code"; Code[20])
        {
            Caption = 'Pack Size Code';
            DataClassification = CustomerContent;
        }
        field(50121; "PackSize_Value"; Decimal)
        {
            Caption = 'Pack Size';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
    }
}
