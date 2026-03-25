
*** Settings ***
Resource    ../BaseTests.resource
Resource    ../step-defs/auth_steps.resource
Resource    ../pages/ForgotPasswordPage.resource
Resource    ../pages/LoginPage.resource

Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown     Test Teardown

*** Test Cases ***
Scenario: Demander un lien de réinitialisation
    Given l'application est ouverte sur la page de connexion
    When Aller Vers Mot De Passe Oublié
    When Attendre Page Reset
    When Demander Lien De Reinit    ${USER_NO_2FA_EMAIL}
    Then Verifier Reset OK

    When Demander Lien De Reinit    personne.inconnue@example.org
    Then Verifier Reset En Erreur
    Then Retourner A La Connexion
    Then Attendre Page Connexion
