
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***
${ERROR_TRANSFER}            css:[data-testid="transfer-error"]
${SUCCESS_TRANSFER}          css:[data-testid="transfer-success"]
${BTN_INTERNAL}              css:[data-testid="btn-transfer-internal"]
${BTN_EXTERNAL}              css:[data-testid="btn-transfer-external"]
${SELECT_FROM}               css:[data-testid="select-from-account"]
${SELECT_TO}                 css:[data-testid="select-to-account"]
${INPUT_AMOUNT}              css:[data-testid="input-amount"]
${INPUT_DESC}                css:[data-testid="input-description"]
${BTN_SUBMIT_TRANSFER}       css:[data-testid="btn-submit-transfer"]

# Bénéficiaires + modale
${BEN_LIST}                  css:[data-testid="beneficiary-list"]
${BTN_ADD_BEN}               css:[data-testid="btn-add-beneficiary"]
${MODAL_ADD_BEN}             css:[data-testid="modal-add-beneficiary"]
${INPUT_BEN_NAME}            css:[data-testid="input-beneficiary-name"]
${INPUT_BEN_IBAN}            css:[data-testid="input-beneficiary-iban"]
${BTN_CANCEL_BEN}            css:[data-testid="btn-cancel-beneficiary"]
${BTN_SAVE_BEN}              css:[data-testid="btn-save-beneficiary"]

*** Keywords ***
Attendre Page Virement
    Wait Until Element Is Visible    ${BTN_INTERNAL}    ${WAIT_MEDIUM}

Choisir Virement Interne
    Click Element    ${BTN_INTERNAL}

Choisir Virement Vers Tiers
    Click Element    ${BTN_EXTERNAL}

Selectionner Compte Debiteur Par Id
    [Arguments]    ${account_id}
    Select From List By Value    ${SELECT_FROM}    ${account_id}

Selectionner Compte Crediteur Par Id
    [Arguments]    ${account_id}
    Select From List By Value    ${SELECT_TO}      ${account_id}

Selectionner Beneficiaire Par Id
    [Arguments]    ${beneficiary_id}
    Click Element    css:[data-testid="beneficiary-${beneficiary_id}"]

Ouvrir Modale Ajout Beneficiaire
    Click Element    ${BTN_ADD_BEN}
    Wait Until Element Is Visible    ${MODAL_ADD_BEN}    ${WAIT_MEDIUM}

Annuler Ajout Beneficiaire
    Click Element    ${BTN_CANCEL_BEN}
    Wait Until Element Is Not Visible    ${MODAL_ADD_BEN}    ${WAIT_MEDIUM}

Ajouter Beneficiaire
    [Arguments]    ${name}    ${iban}
    Input Text      ${INPUT_BEN_NAME}    ${name}
    Input Text      ${INPUT_BEN_IBAN}    ${iban}
    Click Element   ${BTN_SAVE_BEN}
    Wait Until Element Is Not Visible    ${MODAL_ADD_BEN}    ${WAIT_MEDIUM}

Renseigner Montant Et Motif
    [Arguments]    ${amount}    ${motif}=${EMPTY}
    Input Text    ${INPUT_AMOUNT}    ${amount}
    IF    '${motif}' != ''
        Input Text    ${INPUT_DESC}      ${motif}
    END

Soumettre Virement
    Click Element    ${BTN_SUBMIT_TRANSFER}

Verifier Virement OK
    Wait Until Element Is Visible    ${SUCCESS_TRANSFER}    ${WAIT_MEDIUM}
    Page Should Contain               Virement effectué avec succès

Verifier Erreur Virement
    [Arguments]    ${message_part}
    Wait Until Element Is Visible    ${ERROR_TRANSFER}    ${WAIT_MEDIUM}
    ${txt}=    Get Text    ${ERROR_TRANSFER}
    Should Contain    ${txt}    ${message_part}
