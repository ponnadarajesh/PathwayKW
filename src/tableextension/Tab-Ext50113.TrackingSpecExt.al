tableextension 50113 "Tracking Specification Ext" extends "Tracking Specification"
{
    fields
    {
        field(50116; "PackSize_Code"; Code[20])
        {
            Caption = 'Pack Size Code';
            DataClassification = CustomerContent;
        }
        field(50117; "PackSize_Value"; Decimal)
        {
            Caption = 'Pack Size';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(50118; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
    }
}
