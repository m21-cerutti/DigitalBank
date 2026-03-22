
*** Settings ***
Resource    ../BaseTests.resource
Resource    ../step-defs/auth_steps.resource
Resource    ../step-defs/nav_steps.resource
Resource    ../step-defs/transfer_steps.resource

Suite Setup       Suite Setup
Suite Teardown    Suite Teardown
Test Teardown     Test Teardown

*** Test Cases ***
Scenario: Virement externe vers un beneficiaire existant puis ajout d'un nouveau
    Given l'application est ouverte sur la page de connexion
    When je me connecte avec l'utilisateur sans 2FA
    And je vais sur l'onglet "transfer"
    When je fais un virement externe de 25.00€ depuis le compte 4 vers le beneficiaire 3
    Then le virement est confirme
    When j'ajoute un nouveau beneficiaire "Nouveau Benef" avec l'iban "FR7612341234123412341234123"
