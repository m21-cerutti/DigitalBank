
*** Settings ***
Resource    ../pages/BillsPage.resource

*** Keywords ***
When je paie la facture ${bill_id}
    Payer Facture Par Id    ${bill_id}

Then le paiement de facture est confirme
    Verifier Paiement OK

Then la facture ${bill_id} apparait dans les factures payees
    Verifier Facture Est Dans Liste Payees    ${bill_id}
