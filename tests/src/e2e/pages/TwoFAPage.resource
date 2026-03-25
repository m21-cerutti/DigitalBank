
*** Settings ***
Library     String
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***
${ERROR_2FA}           css:[data-testid="2fa-error"]
${BTN_VERIFY_2FA}      css:[data-testid="btn-verify-2fa"]

*** Keywords ***
Attendre Page 2FA
    Wait Until Element Is Visible    ${BTN_VERIFY_2FA}    ${WAIT_MEDIUM}

Saisir Code 2FA
    [Arguments]    ${code}
    FOR    ${i}    IN RANGE    0    6
        ${digit}=    Get Substring    ${code}    ${i}    1
        Input Text    css:[data-testid="2fa-code-${i}"]    ${digit}
    END

Valider 2FA
    Click Element   ${BTN_VERIFY_2FA}

Verifier Erreur 2FA
    [Arguments]    ${message_part}=Code de vérification incorrect
    Wait Until Element Is Visible    ${ERROR_2FA}    ${WAIT_MEDIUM}
    ${txt}=    Get Text    ${ERROR_2FA}
    Should Contain    ${txt}    ${message_part}
