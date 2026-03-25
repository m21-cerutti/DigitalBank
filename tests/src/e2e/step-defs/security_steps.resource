
*** Settings ***
Resource    ../pages/SecurityPage.resource
Resource    ../BaseVariables.resource

*** Keywords ***
When j'active la double authentification
    Basculer 2FA    ${true}

When je desactive la double authentification
    Basculer 2FA    ${false}

Then je vois le message securite contenant "${message}"
    Verifier Message Securite    ${message}

When je modifie mon mot de passe de "${current}" vers "${newpwd}"
    Ouvrir Modale Changer Mot De Passe
    Changer Mot De Passe    ${current}    ${newpwd}    ${newpwd}

Then la modification de mot de passe reussit
    Verifier Changement Mot De Passe OK
