
*** Settings ***
Resource    ../BaseTests.resource
Resource    ../step-defs/auth_steps.resource
Resource    ../step-defs/nav_steps.resource
Resource    ../step-defs/bills_steps.resource

Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown     Test Teardown

*** Test Cases ***
Scenario: Payer une facture EDF
    Given l'application est ouverte sur la page de connexion
    When je me connecte avec l'utilisateur sans 2FA
    When je vais sur l'onglet "bills"
    When je paie la facture 1
    Then le paiement de facture est confirme
    Then la facture 1 apparait dans les factures payees
