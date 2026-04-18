reportextension 50101 "Extra Fields on Sales Conf" extends 1305
{
    dataset
    {
        add("Line")
        {
            column("PackSizeCode"; "PackSize_Code")
            {
            }
            column("PackSize"; "PackSize_Value")
            {
            }
            column("Description2"; "Description 2")
            {
            }
        }
    }
}
