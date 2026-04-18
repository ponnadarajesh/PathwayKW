reportextension 50103 "ExtraFields on PickInstruction" extends 214
{
    dataset
    {
        add("Sales Line")
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
            column(LotNoTxt; GetLotNumbers("Sales Line"))
            {
            }
        }
    }
    procedure GetLotNumbers(SLine: Record "Sales Line"): Text var
        TrackSpec: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        LotNumbers: Text;
    begin
        if SLine."Quantity Shipped" > 0 then begin //if the item partially or fully shipped, then refer to Tracking Specification.
            // Filter Tracking Specification Entries for the specific Sales Line
            TrackSpec.SetRange("Item No.", SLine."No.");
            TrackSpec.SetRange("Source Type", Database::"Sales Line");
            TrackSpec.SetRange("Source Subtype", SLine."Document Type");
            TrackSpec.SetRange("Source ID", SLine."Document No.");
            TrackSpec.SetRange("Source Ref. No.", SLine."Line No.");
            if TrackSpec.Findfirst()then begin
                repeat if TrackSpec."Lot No." <> '' then begin
                        if LotNumbers = '' then LotNumbers:=TrackSpec."Lot No."
                        else
                            LotNumbers+=', ' + TrackSpec."Lot No.";
                    end;
                until TrackSpec.Next() = 0;
            end;
        end
        else
        begin // If the item is not shipped yet, then refer to Reservation Entries.
            // Get Lot Nos from Reservation Entries if not completely shipped
            ReservEntry.SetRange("Item No.", SLine."No.");
            ReservEntry.SetRange("Source Type", Database::"Sales Line");
            ReservEntry.SetRange("Source ID", SLine."Document No.");
            ReservEntry.SetRange("Source Ref. No.", SLine."Line No.");
            if ReservEntry.Findfirst()then begin
                repeat if ReservEntry."Lot No." <> '' then begin
                        if LotNumbers = '' then LotNumbers:=ReservEntry."Lot No."
                        else
                            LotNumbers+=', ' + ReservEntry."Lot No.";
                    end;
                until ReservEntry.Next() = 0;
            end;
        end;
        exit(LotNumbers);
    end;
}
