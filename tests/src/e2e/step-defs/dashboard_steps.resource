
*** Settings ***
Resource    ../pages/DashboardPage.resource

*** Keywords ***
Then le compte ${account_id} est selectionne
    Verifier Carte Compte Selectionnee    ${account_id}

When je selectionne le compte ${account_id}
    Cliquer Carte Compte Par Id    ${account_id}

Then je vois le solde du compte ${account_id}
    ${solde}=    Lire Solde Compte    ${account_id}
    Should Contain    ${solde}    €
