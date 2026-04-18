table 50100 "Inventory Report Buffer"
{
    TableType = Temporary;
    Caption = 'Inventory Report Buffer';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Doc. No.';
        }
        field(3; "Document Type"; Text[15])
        {
            Caption = 'Document Type';
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(6; "Requested Date"; Date)
        {
            Caption = 'Requested Date';
        }
        field(7; "Promised Date"; Date)
        {
            Caption = 'Promised Date';
        }
        field(8; "Qty On PO"; Decimal)
        {
            Caption = 'Qty. on PO';
        }
        field(9; "Qty On SO"; Decimal)
        {
            Caption = 'Qty. on SO';
        }
        field(10; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
    }
    keys
    {
        // Primary key is Line No.
        key(PK; "Line No.")
        {
            Clustered = true;
        }
        // We add a key for sorting by Date in the report
        key(SortByDate; "Promised Date")
        {
        }
    }
}
