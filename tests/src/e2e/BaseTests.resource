
*** Settings ***

# Library           ./libs/Common.py
Library           SeleniumLibrary
Resource          BaseVariables.resource

*** Keywords ***
Suite Setup
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    # Call Method    ${options}    add_argument      incognito
    Call Method    ${options}    add_argument      --disable-notifications
    Call Method    ${options}    add_argument      --disable-infobars
    Call Method    ${options}    add_argument      --disable-extensions
    Call Method    ${options}    add_argument      --no-sandbox
    Call Method    ${options}    add_argument      --start-maximized
    Call Method    ${options}    add_argument      --disable-search-engine-choice-screen
    Call Method    ${options}    add_argument      --ignore-certificate-errors
    Call Method    ${options}    add_argument      --disable-gpu
    Call Method    ${options}    add_argument      --allow-insecure-localhost
    ${excludeSwitches}    Create List    enable-automation    enable-logging    disable-popup-blocking
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}
    IF    ${HEADLESS}
        Call Method    ${options}    add_argument    --headless
    END
    Open Browser    ${APP_URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Selenium Timeout      ${WAIT_LONG}

Suite Teardown
    Close All Browsers

Test Teardown
    Capture Page Screenshot
