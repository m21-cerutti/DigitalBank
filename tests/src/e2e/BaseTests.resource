
*** Settings ***

# Library           ./libs/Common.py
Library           SeleniumLibrary
Resource          BaseVariables.resource

*** Keywords ***
Suite Setup
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    IF    ${HEADLESS}
        ${headlessArg}=    Set Variable      
        ...    --headless=new
        Call Method    ${options}    add_argument    ${headlessArg}
    END
    # Call Method    ${options}    add_argument      --incognito
    Call Method    ${options}    add_argument      --disable-notifications
    Call Method    ${options}    add_argument      --disable-infobars
    Call Method    ${options}    add_argument      --disable-extensions
    Call Method    ${options}    add_argument      --no-sandbox
    Call Method    ${options}    add_argument      --start-maximized
    Call Method    ${options}    add_argument      --disable-search-engine-choice-screen
    Call Method    ${options}    add_argument      --ignore-certificate-errors
    Call Method    ${options}    add_argument      --disable-gpu
    Call Method    ${options}    add_argument      --allow-insecure-localhost
    Call Method    ${options}    add_argument      --disable-dev-shm-usag

    ${windowsSize}=    Set Variable                --window-size=1920,1080 
    Call Method    ${options}    add_argument      ${windowsSize}

    ${userAgent}=      Set Variable     
    ...    user-agent="Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19"
    Call Method    ${options}  add_argument  ${userAgent}

    ${excludeSwitches}    Create List    enable-automation    enable-logging    disable-popup-blocking
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}

    
    Set Selenium Timeout      ${WAIT_LONG}
    Open Browser    ${APP_URL}    ${BROWSER}    options=${options}
    Set Window Size    1920    1080
    IF    not ${HEADLESS}
        Maximize Browser Window
    END
    ${width}=    Execute Javascript    return window.innerWidth
    Log    ${width}

Suite Teardown
    Close All Browsers

Test Teardown
    Capture Page Screenshot
