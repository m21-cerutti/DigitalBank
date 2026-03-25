
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***
${INPUT_RESET_EMAIL}     css:[data-testid="input-reset-email"]
${BTN_RESET_PASSWORD}    css:[data-testid="btn-reset-password"]
${LINK_BACK_TO_LOGIN}    css:[data-testid="link-back-to-login"]
${RESET_ERROR}           css:[data-testid="reset-error"]
${RESET_SUCCESS}         css:[data-testid="reset-success"]

*** Keywords ***
Attendre Page Reset
    Wait Until Element Is Visible    ${BTN_RESET_PASSWORD}    ${WAIT_MEDIUM}

Demander Lien De Reinit
    [Arguments]    ${email}
    Input Text      ${INPUT_RESET_EMAIL}    ${email}
    Click Element   ${BTN_RESET_PASSWORD}

Verifier Reset OK
    Wait Until Element Is Visible    ${RESET_SUCCESS}    ${WAIT_MEDIUM}

Verifier Reset En Erreur
    Wait Until Element Is Visible    ${RESET_ERROR}      ${WAIT_MEDIUM}

Retourner A La Connexion
    Click Element    ${LINK_BACK_TO_LOGIN}
