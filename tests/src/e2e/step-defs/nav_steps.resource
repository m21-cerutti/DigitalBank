
*** Settings ***
Resource    ../pages/MainApp.resource
Resource    ../pages/DashboardPage.resource
Resource    ../pages/TransferPage.resource
Resource    ../pages/BillsPage.resource
Resource    ../pages/SecurityPage.resource

*** Keywords ***
When je vais sur l'onglet "${onglet}"
    Aller Onglet    ${onglet}

And je vais sur l'onglet "${onglet}"
    Aller Onglet    ${onglet}