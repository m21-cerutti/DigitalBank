
*** Settings ***
Resource    ../BaseTests.resource
Resource    ../step-defs/auth_steps.resource
Resource    ../step-defs/nav_steps.resource
Resource    ../step-defs/security_steps.resource

Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown     Test Teardown

*** Test Cases ***
Scenario: Activer 2FA puis changer le mot de passe
    Given l'application est ouverte sur la page de connexion
    When je me connecte avec l'utilisateur sans 2FA
    When je vais sur l'onglet "security"
    When j'active la double authentification
    Then je vois le message securite contenant "Double authentification activée"

    When je modifie mon mot de passe de "${USER_NO_2FA_PASSWORD}" vers "NewPass1!"
    Then la modification de mot de passe reussit
