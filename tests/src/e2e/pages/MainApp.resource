
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***

*** Keywords ***
Attendre Application
    Wait Until Element Is Visible    ${HEADER_USER_NAME}    ${WAIT_LONG}
    Wait Until Element Is Visible    ${TAB_DASHBOARD}      ${WAIT_MEDIUM}

Lire Nom Utilisateur Header
    ${name}=    Get Text    ${HEADER_USER_NAME}
    RETURN    ${name}

Aller Onglet
    [Arguments]    ${onglet}   # dashboard | transfer | bills | security
    Run Keyword If    '${onglet}'=='dashboard'    Click Element    ${TAB_DASHBOARD}
    ...    ELSE IF    '${onglet}'=='transfer'     Click Element    ${TAB_TRANSFER}
    ...    ELSE IF    '${onglet}'=='bills'        Click Element    ${TAB_BILLS}
    ...    ELSE IF    '${onglet}'=='security'     Click Element    ${TAB_SECURITY}
    ...    ELSE    Fail    Onglet inconnu: ${onglet}
    Attendre Application

Se Deconnecter
    Click Element    ${BTN_LOGOUT}
