# ADR-0001 — Quel outil pour l’E2E UI ?

## Contexte

Nous devons automatiser un petit nombre de parcours critiques UI (login, 2FA, paiement, virement).

## Options

- Playwright
- Cypress
- **RobotFramework** + SeleniumLibrary

## Décision

Nous choisissons **RobotFramework** + SeleniumLibrary. Raison : lisibilité Gherkin-like, standard de test fonctionnel, facile à partager avec des non-dev, et compatible avec la matrice navigateurs et éventuels évolutions mobile.

## Conséquences

- Ajout de suites `.robot` pour les parcours critiques.
- Besoin d’un serveur local pendant l’exécution CI.
