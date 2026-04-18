reportextension 50100 "Extra Fields on PO" extends 16034400
{
    dataset
    {
        add("Purchase Line")
        {
            column("PackSizeCode"; "PackSize_Code")
            {
            }
            column("PackSize"; "PackSize_Value")
            {
            }
            column(BaseUOM; Item."Base Unit of Measure")
            {
                Caption = 'Base Unit of Measure';
                // IncludeCaption = true;   // Uncomment if you want to use the standard caption from the Item table
            }

        }
        modify("Purchase Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                // Ensure that the related Item record is loaded to fetch the Base Unit of Measure
                if "No." <> '' then
                    if Item.Get("No.") then;
            end;

        }
    }
    var
        Item: Record Item;
}
