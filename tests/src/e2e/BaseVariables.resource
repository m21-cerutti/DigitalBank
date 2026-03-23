
*** Settings ***
# Variables communes (SeleniumLibrary)

*** Variables ***
${APP_URL}                http://127.0.0.1:5173/
# ${BROWSER}                headlesschrome
${BROWSER}                chrome
${HEADLESS}               ${false}
${VIEWPORT_WIDTH}         1440
${VIEWPORT_HEIGHT}        900
${WAIT_SHORT}             1s
${WAIT_MEDIUM}            5s
${WAIT_LONG}              10s

# Utilisateurs de test
${USER_NO_2FA_EMAIL}      test@digitalbank.fr
${USER_NO_2FA_PASSWORD}   Test1234!
${USER_2FA_EMAIL}         marie.martin@email.com
${USER_2FA_PASSWORD}      SecurePass456!
${VALID_2FA_CODE}         123456

# Sélecteurs de navigation (Main App)
${TAB_DASHBOARD}          css:[data-testid="tab-dashboard"]
${TAB_TRANSFER}           css:[data-testid="tab-transfer"]
${TAB_BILLS}              css:[data-testid="tab-bills"]
${TAB_SECURITY}           css:[data-testid="tab-security"]

# Commun header/footer
${HEADER_USER_NAME}       css:[data-testid="header-user-name"]
${BTN_LOGOUT}             css:[data-testid="btn-logout"]
