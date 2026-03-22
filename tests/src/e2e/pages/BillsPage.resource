
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseTests.resource

*** Variables ***
${SUCCESS_BILL}              css:[data-testid="bill-success"]
${PENDING_BILLS}             css:[data-testid="pending-bills"]
${PAID_BILLS}                css:[data-testid="paid-bills"]
${MODAL_CONFIRM}             css:[data-testid="modal-confirm-payment"]
${BTN_CANCEL_PAYMENT}        css:[data-testid="btn-cancel-payment"]
${BTN_CONFIRM_PAYMENT}       css:[data-testid="btn-confirm-payment"]

*** Keywords ***
Attendre Page Factures
    Wait Until Element Is Visible    ${PENDING_BILLS}    ${WAIT_MEDIUM}

Payer Facture Par Id
    [Arguments]    ${bill_id}
    Click Element    css:[data-testid="btn-pay-bill-${bill_id}"]
    Wait Until Element Is Visible    ${MODAL_CONFIRM}    ${WAIT_MEDIUM}
    Click Element    ${BTN_CONFIRM_PAYMENT}
    Wait Until Element Is Not Visible    ${MODAL_CONFIRM}    ${WAIT_MEDIUM}

Verifier Paiement OK
    Wait Until Element Is Visible    ${SUCCESS_BILL}    ${WAIT_MEDIUM}
    Page Should Contain    payée avec succès

Verifier Facture Est Dans Liste Payees
    [Arguments]    ${bill_id}
    Wait Until Element Is Visible    ${PAID_BILLS}    ${WAIT_MEDIUM}
    Wait Until Element Is Visible    css:[data-testid="bill-paid-${bill_id}"]    ${WAIT_MEDIUM}
