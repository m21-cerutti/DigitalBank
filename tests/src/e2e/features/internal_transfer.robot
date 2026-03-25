
*** Settings ***
Resource    ../BaseTests.resource
Resource    ../step-defs/auth_steps.resource
Resource    ../step-defs/nav_steps.resource
Resource    ../step-defs/transfer_steps.resource
Resource    ../step-defs/dashboard_steps.resource

Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown     Test Teardown

*** Test Cases ***
Scenario: Virement interne entre mes comptes
    Given l'application est ouverte sur la page de connexion
    When je me connecte avec l'utilisateur sans 2FA
    And je vais sur l'onglet "dashboard"
    Then je vois le solde du compte 4
    
    When je vais sur l'onglet "transfer"
    When je fais un virement interne de 50.00€ du compte 4 vers le compte 5
    Then le virement est confirme
    And je vais sur l'onglet "dashboard"
    Then le compte 4 est selectionne
