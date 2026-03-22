
*** Settings ***

# Library           ./libs/Common.py
Library           SeleniumLibrary
Resource          BaseVariables.resource

*** Keywords ***
Suite Setup
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # Call Method    ${options}    add_argument    incognito
    Call Method    ${options}    add_argument    start-maximized
    Call Method    ${options}    add_argument    disable-search-engine-choice-screen
    Call Method    ${options}    add_argument    ignore-certificate-errors
    ${excludeSwitches}    Create List    enable-automation    enable-logging    disable-popup-blocking
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}
    IF    ${HEADLESS}
        Call Method    ${options}    add_argument    headless
    END
    IF    ${HEADLESS}
        Open Browser    ${APP_URL}    ${BROWSER}    options=${options}
    ELSE    
        Open Browser    ${APP_URL}    ${BROWSER}
    END
    Maximize Browser Window
    Set Selenium Timeout      ${WAIT_LONG}

Suite Teardown
    Close All Browsers

Test Teardown
    Capture Page Screenshot
