
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***
${INPUT_EMAIL}            css:[data-testid="input-email"]
${INPUT_PASSWORD}         css:[data-testid="input-password"]
${CHECK_REMEMBER}         css:[data-testid="checkbox-remember"]
${BTN_LOGIN}              css:[data-testid="btn-login"]
${LINK_FORGOT}            css:[data-testid="link-forgot-password"]
${ERROR_LOGIN}            css:[data-testid="login-error"]

*** Keywords ***
Attendre Page Connexion
    Wait Until Element Is Visible    ${BTN_LOGIN}    ${WAIT_MEDIUM}

Saisir Identifiants
    [Arguments]    ${email}    ${password}    ${remember}=False
    Input Text      ${INPUT_EMAIL}        ${email}
    Input Text      ${INPUT_PASSWORD}     ${password}
    IF    ${remember}
        Select Checkbox    ${CHECK_REMEMBER}
    END

Cliquer Se Connecter
    Click Element           ${BTN_LOGIN}

Aller Vers Mot De Passe Oublié
    Click Element           ${LINK_FORGOT}

Verifier Erreur Connexion
    [Arguments]     ${message_part}=Email ou mot de passe incorrect
    Wait Until Element Is Visible    ${ERROR_LOGIN}    ${WAIT_MEDIUM}
    ${txt}=    Get Text    ${ERROR_LOGIN}
    Should Contain          ${txt}    ${message_part}
