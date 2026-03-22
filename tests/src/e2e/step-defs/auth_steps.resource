
*** Settings ***
Resource    ../pages/LoginPage.resource
Resource    ../pages/TwoFAPage.resource
Resource    ../pages/MainApp.resource
Resource    ../BaseVariables.resource

*** Keywords ***
Given l'application est ouverte sur la page de connexion
    Attendre Page Connexion

When je me connecte avec l'utilisateur sans 2FA
    Saisir Identifiants    ${USER_NO_2FA_EMAIL}    ${USER_NO_2FA_PASSWORD}
    Cliquer Se Connecter
    Attendre Application

When je me connecte avec l'utilisateur 2FA
    Saisir Identifiants    ${USER_2FA_EMAIL}    ${USER_2FA_PASSWORD}
    Cliquer Se Connecter
    Attendre Page 2FA

When je saisis le code 2FA valide
    Saisir Code 2FA    ${VALID_2FA_CODE}
    Valider 2FA
    Attendre Application

Then je vois mon nom dans le header
    ${name}=    Lire Nom Utilisateur Header
    Should Not Be Empty    ${name}

Then je me deconnecte
    Se Deconnecter
    Attendre Page Connexion
