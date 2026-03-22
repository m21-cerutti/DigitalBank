
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***
${ALERT_SECURITY}            css:[data-testid="security-success"]
# TODO Problem need click parent toggle-switch (or not interactable)
${TOGGLE_2FA}                xpath://input[@data-testid="toggle-2fa"]/..
${TOGGLE_EMAIL}              css:[data-testid="toggle-email-notifications"]
${TOGGLE_SMS}                css:[data-testid="toggle-sms-notifications"]
${BTN_CHANGE_PWD}            css:[data-testid="btn-change-password"]
${MODAL_CHANGE_PWD}          css:[data-testid="modal-change-password"]
${INPUT_CUR_PWD}             css:[data-testid="input-current-password"]
${INPUT_NEW_PWD}             css:[data-testid="input-new-password"]
${INPUT_CONFIRM_PWD}         css:[data-testid="input-confirm-password"]
${BTN_CANCEL_PWD}            css:[data-testid="btn-cancel-password"]
${BTN_SAVE_PWD}              css:[data-testid="btn-save-password"]
${ERROR_PWD}                 css:[data-testid="password-error"]
${REQ_BOX}                   css:[data-testid="password-requirements"]

${USER_NAME_FIELD}           css:[data-testid="user-name"]
${USER_EMAIL_FIELD}          css:[data-testid="user-email"]
${USER_PHONE_FIELD}          css:[data-testid="user-phone"]

*** Keywords ***
Attendre Page Securite
    Wait Until Element Is Visible    ${BTN_CHANGE_PWD}    ${WAIT_MEDIUM}

Basculer 2FA
    [Arguments]    ${enabled}=${true}
    Wait Until Element Is Visible     ${TOGGLE_2FA}
    ${is_selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${TOGGLE_2FA}
    IF    ${enabled} and not ${is_selected}    
        Click Element    ${TOGGLE_2FA}
    ELSE IF    not ${enabled} and ${is_selected}    
        Click Element    ${TOGGLE_2FA}
    END

Verifier Message Securite
    [Arguments]    ${message_part}
    Wait Until Element Is Visible    ${ALERT_SECURITY}    ${WAIT_MEDIUM}
    ${txt}=    Get Text    ${ALERT_SECURITY}
    Should Contain    ${txt}    ${message_part}

Ouvrir Modale Changer Mot De Passe
    Click Element    ${BTN_CHANGE_PWD}
    Wait Until Element Is Visible    ${MODAL_CHANGE_PWD}    ${WAIT_MEDIUM}

Annuler Changement Mot De Passe
    Click Element    ${BTN_CANCEL_PWD}
    Wait Until Element Is Not Visible    ${MODAL_CHANGE_PWD}    ${WAIT_MEDIUM}

Changer Mot De Passe
    [Arguments]    ${current}    ${new}    ${confirm}
    Input Text      ${INPUT_CUR_PWD}     ${current}
    Input Text      ${INPUT_NEW_PWD}     ${new}
    Input Text      ${INPUT_CONFIRM_PWD}    ${confirm}
    Click Element   ${BTN_SAVE_PWD}

Verifier Erreur Mot De Passe
    [Arguments]    ${message_part}
    Wait Until Element Is Visible    ${ERROR_PWD}    ${WAIT_MEDIUM}
    ${txt}=    Get Text    ${ERROR_PWD}
    Should Contain    ${txt}    ${message_part}

Verifier Changement Mot De Passe OK
    Wait Until Element Is Visible    ${ALERT_SECURITY}    ${WAIT_MEDIUM}
    Page Should Contain    Mot de passe modifié avec succès

Lire Infos Utilisateur
    ${name}=    Get Text    ${USER_NAME_FIELD}
    ${email}=   Get Text    ${USER_EMAIL_FIELD}
    ${phone}=   Get Text    ${USER_PHONE_FIELD}
    RETURN    ${name}    ${email}    ${phone}
