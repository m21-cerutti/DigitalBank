
*** Settings ***
Resource    ../pages/TransferPage.resource
Resource    ../pages/DashboardPage.resource

*** Keywords ***
When je fais un virement interne de ${montant}€ du compte ${from_id} vers le compte ${to_id}
    Choisir Virement Interne
    Selectionner Compte Debiteur Par Id      ${from_id}
    Selectionner Compte Crediteur Par Id     ${to_id}
    Renseigner Montant Et Motif              ${montant}    Test interne
    Soumettre Virement

Then le virement est confirme
    Verifier Virement OK

When je fais un virement externe de ${montant}€ depuis le compte ${from_id} vers le beneficiaire ${beneficiary_id}
    Choisir Virement Vers Tiers
    Selectionner Compte Debiteur Par Id      ${from_id}
    Selectionner Beneficiaire Par Id         ${beneficiary_id}
    Renseigner Montant Et Motif              ${montant}    Test externe
    Soumettre Virement

When j'ajoute un nouveau beneficiaire "${name}" avec l'iban "${iban}"
    Ouvrir Modale Ajout Beneficiaire
    Ajouter Beneficiaire    ${name}    ${iban}
