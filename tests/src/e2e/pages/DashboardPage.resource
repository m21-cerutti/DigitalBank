
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***
${BALANCE_CARDS}         css:[data-testid="balance-cards"]
${TX_LIST}               css:[data-testid="transaction-list"]

*** Keywords ***
Attendre Dashboard
    Wait Until Element Is Visible    ${BALANCE_CARDS}    ${WAIT_MEDIUM}

Cliquer Carte Compte Par Id
    [Arguments]    ${account_id}
    Click Element    css:[data-testid="account-card-${account_id}"]

Verifier Carte Compte Selectionnee
    [Arguments]    ${account_id}
    ${class}=    Get Element Attribute    css:[data-testid="account-card-${account_id}"]    class
    Should Contain    ${class}    selected

Lire Solde Compte
    [Arguments]    ${account_id}
    ${txt}=    Get Text    css:[data-testid="balance-${account_id}"]
    RETURN    ${txt}

Verifier Transaction Presente
    [Arguments]    ${tx_id}
    Wait Until Element Is Visible    css:[data-testid="transaction-${tx_id}"]    ${WAIT_MEDIUM}

Verifier Aucune Transaction Recente
    Page Should Contain    Aucune transaction récente
