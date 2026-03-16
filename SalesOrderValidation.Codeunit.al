codeunit 50105 "SalesOrderValidator"
{
    // This code runs automatically when a Sales Header is inserted
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', true, true)]
    local procedure CheckCustomerCredit(var Rec: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        // Logic: If the customer has no credit limit, send a warning
        if Cust.Get(Rec."Sell-to Customer No.") then begin
            if Cust."Credit Limit (LCY)" = 0 then
                Message('Technical Alert: Customer %1 has no credit limit. Please verify with Finance.', Cust.Name);
        end;
    end;
}
