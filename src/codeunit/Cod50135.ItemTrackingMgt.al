// // codeunit 50135 "ItemTrackingMgt"
// // {
// //  [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInsertEvent', '', false, false)]
// //      local procedure TrackingSpec_OnAfterInsert(var Rec: Record "Tracking Specification"; RunTrigger: Boolean)
// //      begin
// //          SetPackConfigFromPurchaseLine(Rec);
// //      end;

// //      [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterModifyEvent', '', false, false)]
// //      local procedure TrackingSpec_OnAfterModify(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification"; RunTrigger: Boolean)
// //      begin
// //          // If lot no/serial no gets assigned later, this ensures Pack Configuration is set/kept aligned
// //          SetPackConfigFromPurchaseLine(Rec);
// //      end;

// //      local procedure SetPackConfigFromPurchaseLine(var TrackSpec: Record "Tracking Specification")
// //      var
// //          PurchLine: Record "Purchase Line";
// //          PurchDocType: Enum "Purchase Document Type";
// //      begin
// //          // Only when the tracking spec belongs to Purchase Line
// //          if TrackSpec."Source Type" <> Database::"Purchase Line" then
// //              exit;

// //          // Map Source Subtype -> Purchase Document Type (common mapping: 1 = Order)
// //          // If your environment uses different mapping, adjust this case.
// //          case TrackSpec."Source Subtype" of
// //              0:
// //                  PurchDocType := PurchDocType::Quote;
// //              1:
// //                  PurchDocType := PurchDocType::Order;
// //              2:
// //                  PurchDocType := PurchDocType::Invoice;
// //              3:
// //                  PurchDocType := PurchDocType::"Credit Memo";
// //              4:
// //                  PurchDocType := PurchDocType::"Blanket Order";
// //              5:
// //                  PurchDocType := PurchDocType::"Return Order";
// //              else
// //                  exit;
// //          end;

// //          PurchLine.SetRange("Document Type", PurchDocType);
// //          PurchLine.SetRange("Document No.", TrackSpec."Source ID");
// //          PurchLine.SetRange("Line No.", TrackSpec."Source Ref. No.");

// //          if PurchLine.FindFirst() then begin
// //              TrackSpec."Description 2" := PurchLine."Description 2";
// //              TrackSpec."PackSize_Value" := PurchLine."PackSize_Value";
// //              TrackSpec."PackSize_Code" := PurchLine."PackSize_Code";

// //          end;
// //      end;
// // }

codeunit 50121 "Pack Config - ILE Transfer"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure LocalInitItemLedgEntry(
        var NewItemLedgEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Description 2" := ItemJournalLine."Description 2";
        NewItemLedgEntry."PackSize_Value" := ItemJournalLine."PackSize_Value";
        NewItemLedgEntry."PackSize_Code" := ItemJournalLine."PackSize_Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeItemJnlPostLine, '', false, false)]
    local procedure CopyPackConfigToJnlLine(PurchaseLine: Record "Purchase Line"; var ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine."Description 2" := PurchaseLine."Description 2";
        ItemJournalLine."PackSize_Value" := PurchaseLine."PackSize_Value";
        ItemJournalLine."PackSize_Code" := PurchaseLine."PackSize_Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line",
    'OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine', '', false, false)]
    local procedure OnSetupTempSplitItemJnlLine(var TempSplitItemJnlLine: Record "Item Journal Line";
    TempTrackingSpecification: Record "Tracking Specification")
    begin
        TempSplitItemJnlLine."Description 2" := TempTrackingSpecification."Description 2";
        TempSplitItemJnlLine."PackSize_Value" := TempTrackingSpecification."PackSize_Value";
        TempSplitItemJnlLine."PackSize_Code" := TempTrackingSpecification."PackSize_Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Description 2" := ItemJournalLine."Description 2";
        NewItemLedgEntry."PackSize_Value" := ItemJournalLine."PackSize_Value";
        NewItemLedgEntry."PackSize_Code" := ItemJournalLine."PackSize_Code";
    end;

    // [EventSubscriber(ObjectType::Page, Page::"Item Avail. by Lot No. Lines",
    // 'OnAfterCalcAvailQuantities', '', false, false)]
    // local procedure OnAfterCalcAvailQuantities(var AvailabilityInfoBuffer: Record "Availability Info. Buffer" temporary; var Item: Record Item)
    // var
    //     ILE: Record "Item Ledger Entry";
    //     PackConfig: Code[50];
    // begin
    //     if AvailabilityInfoBuffer.IsEmpty() then
    //         exit;

    //     if AvailabilityInfoBuffer.FindSet() then
    //         repeat
    //             PackConfig := '';

    //             // Find a posted ILE for this item+lot (optionally add location filter if you want)
    //             ILE.Reset();
    //             ILE.SetCurrentKey("Item No.", "Lot No.");
    //             ILE.SetRange("Item No.", AvailabilityInfoBuffer."Item No.");
    //             ILE.SetRange("Lot No.", AvailabilityInfoBuffer."Lot No.");

    //             // If you want to respect the page Location Filter, add:
    //             if AvailabilityInfoBuffer.GetFilter("Location Code Filter") <> '' then
    //                 ILE.SetFilter("Location Code", AvailabilityInfoBuffer.GetFilter("Location Code Filter"));

    //             if ILE.FindFirst() then
    //                 PackConfig := ILE."Description 2"; // Assuming Description 2 holds the Pack Configuration info

    //             AvailabilityInfoBuffer."Description 2" := PackConfig;
    //             AvailabilityInfoBuffer.PackSize_Code := ILE."PackSize_Code";
    //             AvailabilityInfoBuffer.PackSize_Value := ILE."PackSize_Value";
    //             AvailabilityInfoBuffer.Modify();
    //         until AvailabilityInfoBuffer.Next() = 0;
    // end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnUpdateDirectUnitCostByFieldOnAfterCalcShouldExit, '', false, false)]
    procedure CalDunitcost(CalledByFieldNo: Integer; CurrFieldNo: Integer; var ShouldExit: Boolean)
    begin
        If currFieldNo = 50103 then
            shouldExit := false;
    end;
}
