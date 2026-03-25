
*** Settings ***
Library     SeleniumLibrary
Resource    ../BaseVariables.resource

*** Variables ***

*** Keywords ***
Attendre Application
    Wait Until Element Is Visible    ${HEADER_USER_NAME}    ${WAIT_LONG}
    Wait Until Element Is Visible    ${TAB_DASHBOARD}      ${WAIT_MEDIUM}
    
    # Page Should Contain Element    xpath=//button[@data-testid="tab-security"]
    # ${display}=    Execute Javascript
    # ...    return window.getComputedStyle(document.querySelector('[data-testid="tab-security"]')).display;
    # Log To Console    ${display}
    # Execute Javascript    document.body.style.zoom = "100%"
    # Execute Javascript    window.resizeTo(1920,1080)
    Capture Page Screenshot

Lire Nom Utilisateur Header
    ${name}=    Get Text    ${HEADER_USER_NAME}
    RETURN    ${name}

Aller Onglet
    [Arguments]    ${onglet}   # dashboard | transfer | bills | security
    Scroll Element Into View    ${TAB_DASHBOARD}
    Run Keyword If    '${onglet}'=='dashboard'    Click Element    ${TAB_DASHBOARD}
    ...    ELSE IF    '${onglet}'=='transfer'     Click Element    ${TAB_TRANSFER}
    ...    ELSE IF    '${onglet}'=='bills'        Click Element    ${TAB_BILLS}
    ...    ELSE IF    '${onglet}'=='security'     Click Element    ${TAB_SECURITY}
    ...    ELSE    Fail    Onglet inconnu: ${onglet}
    Attendre Application

Se Deconnecter
    Click Element    ${BTN_LOGOUT}
